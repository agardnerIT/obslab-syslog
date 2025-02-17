import subprocess
import os, threading
from helpers import *


steps = get_steps(f"/workspaces/{REPOSITORY_NAME}/.devcontainer/testing/steps.txt")
INSTALL_PLAYWRIGHT_BROWSERS = False

def run_command_in_background(step):
    command = ["runme", "run", step]
    with open("nohup.out", "w") as f:
        subprocess.Popen(["nohup"] + command, stdout=f, stderr=f)
# Installing Browsers for Playwright is a time consuming task
# So only install if we need to
# That means if running in non-dev mode (dev mode assumes the person already has everything installed)
# AND the steps file actually contains a playwright test (no point otherwise!)
if DEV_MODE == "FALSE":
    for step in steps:
        if "test_" in step:
            INSTALL_PLAYWRIGHT_BROWSERS = True

if INSTALL_PLAYWRIGHT_BROWSERS:
    subprocess.run(["playwright", "install", "chromium-headless-shell", "--only-shell"])

for step in steps:
    step = step.strip()
    logger.info(f"Running {step}")

    if step.startswith("//") or step.startswith("#"):
        logger.info(f"[{step}] Ignore this step. It is commented out.")
        continue
    
    if "test_" in step:
        logger.info(f"[{step}] This step is a Playwright test.")
        if DEV_MODE == "FALSE": # Standard mode. Run test headlessly
            output = subprocess.run(["pytest", "--capture=no", f"{TESTING_BASE_DIR}/{step}"], capture_output=True, text=True)
        else: # Interactive mode (when a maintainer is improving testing. Spin up the browser visually.
            output = subprocess.run(["pytest", "--capture=no", "--headed", f"{TESTING_BASE_DIR}/{step}"], capture_output=True, text=True)

        if output.returncode != 0 and DEV_MODE == "FALSE":
            logger.error(f"Must create an issue: {step} {output}")
            create_github_issue(output, step_name=step)
        else:
            logger.info(output)
    else:
        command = ["runme", "run", step]

        # If task should be run in background
        # TODO: This is tech debt
        # and should be refactored when
        # runme beta run supports backgrounding
        if "[background]" in step:
            # Run the command in the background and capture the output
            # Create a thread to run the command
            thread = threading.Thread(target=run_command_in_background, args=(step,))
            thread.start()
        else:    
            output = subprocess.run(command, capture_output=True, text=True)
            logger.info(output)
            if output.returncode != 0 and DEV_MODE == "FALSE":
                logger.error(f"Must create an issue: {step} {output}")
                create_github_issue(output, step_name=step)
            else:
                logger.info(output)
