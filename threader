#!/usr/bin/env python3

import subprocess
import sys
import os
import time
import signal
import threading
import re
import fcntl

PID_FILE = "/tmp/threader_pids"


def run_command(cmd):
	"""Runs a command in the background and ensures all tasks are appended correctly."""
	start_time = time.strftime("%H:%M:%S")  # Only store HH:MM:SS time
	try:
		process = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)

		# Append the task to the PID file safely
		with open(PID_FILE, "a") as f:
			fcntl.flock(f, fcntl.LOCK_EX)  # Lock file to prevent race conditions
			f.write(f"{process.pid} {cmd} {start_time} -\n")  # '-' is placeholder for end time
			f.flush()  # Ensure immediate write
			fcntl.flock(f, fcntl.LOCK_UN)  # Unlock file

		print(f"[✅ Started] {cmd} (PID: {process.pid})")

		# Start a background thread to track completion
		threading.Thread(target=track_completion, args=(process.pid, cmd, start_time), daemon=True).start()

	except Exception as e:
		print(f"[❌ Failed] {cmd} -> {e}")


def track_completion(pid, cmd, start_time):
	"""Tracks when a command completes and logs the end time without deleting."""
	try:
		os.waitpid(pid, 0)  # Waits for process to complete

		# Update the PID file with the actual end time
		with open(PID_FILE, "r+") as f:
			fcntl.flock(f, fcntl.LOCK_EX)  # Lock file while updating
			lines = f.readlines()
			f.seek(0)
			f.truncate()

			for line in lines:
				if line.startswith(str(pid)):
					f.write(f"{pid} {cmd} {start_time} ✅\n")  # ✅ indicates completed
				else:
					f.write(line)

			f.flush()
			fcntl.flock(f, fcntl.LOCK_UN)  # Unlock file

	except ChildProcessError:
		pass  # Process already completed


def list_tasks():
	"""Lists all tasks with correct status, ensuring full command extraction."""
	if not os.path.exists(PID_FILE):
		print("No tasks found.")
		return

	with open(PID_FILE, "r") as f:
		lines = f.readlines()

	task_list = []
	for line in lines:
		try:
			match = re.match(r"^(\d+)\s+(.+)\s+(\d{2}:\d{2}:\d{2})\s+(✅|-)", line.strip())
			if not match:
				continue  # Skip invalid lines

			pid, cmd, start_time, completion_status = match.groups()
			pid = int(pid)

			# Check if process is still running
			is_running = os.path.exists(f"/proc/{pid}")
			if is_running:
				status = "☐ BUSY"  # Empty checkbox for busy tasks
			else:
				status = "✅ DONE"  # Checked checkbox for completed tasks

			formatted_line = f"[{start_time}] (PID: {pid}) [{status}] {cmd}"
			task_list.append(formatted_line)
		except ValueError:
			continue  # Skip invalid lines

	if task_list:
		print("\n".join(task_list))
	else:
		print("No tasks found.")


def clean_tasks():
	"""Removes only completed tasks from the PID file."""
	if not os.path.exists(PID_FILE):
		print("No completed tasks to clean.")
		return

	with open(PID_FILE, "r") as f:
		lines = f.readlines()

	running_tasks = [line for line in lines if "-" in line and os.path.exists(f"/proc/{line.split()[0]}")]

	with open(PID_FILE, "w") as f:
		f.writelines(running_tasks)

	print("✅ Cleaned completed tasks.")


def clear_all():
	"""Kills all running tasks and clears the PID file."""
	if not os.path.exists(PID_FILE):
		print("No tasks to clear.")
		return

	with open(PID_FILE, "r") as f:
		lines = f.readlines()

	for line in lines:
		try:
			pid, cmd, _, _ = line.strip().split(" ", 3)
			pid = int(pid)
			os.kill(pid, signal.SIGTERM)  # Kill process
			print(f"[🛑 Killed] {cmd} (PID: {pid})")
		except (ValueError, ProcessLookupError):
			pass

	os.remove(PID_FILE)
	print("✅ Cleared all tasks.")


def main():
	if len(sys.argv) < 2:
		print("Usage:\n  threader command1 ++ command2  # Run tasks\n  threader ls  # List all tasks\n  threader clean  # Remove completed tasks\n  threader clear  # Kill all tasks")
		return

	action = sys.argv[1]

	if action == "ls":
		list_tasks()
		return
	elif action == "clean":
		clean_tasks()
		return
	elif action == "clear":
		clear_all()
		return

	full_command = " ".join(sys.argv[1:])
	commands = [cmd.strip() for cmd in full_command.split("++") if cmd.strip()]

	for cmd in commands:
		run_command(cmd)


if __name__ == "__main__":
	main()
