# **🚀 The Mini Terminal Multi-Tasker**

## **🔥 What is **`threader`**?**

`threader` is a **lightweight, powerful, and user-friendly** terminal tool that allows you to run multiple commands **in parallel** on separate threads—**without blocking your terminal**. Think of it as a **background task manager** that keeps track of running and completed tasks.

✅ **Instant parallel execution**\
✅ **No waiting—prompt returns immediately**\
✅ **Check task status anytime with **``\
✅ **No missing tasks—every job is recorded**\
✅ **Easily clean up completed tasks**

---

## **🎯 How **`threader`** Works**

### **1️⃣ Start multiple commands in the background**

```sh
threader sleep 10 ++ echo Hello ++ uname -a
```

🎯 **All commands run in parallel**—no waiting!

### **2️⃣ Check running & completed tasks anytime**

```sh
threader list
```

✅ Shows **live updates** on which tasks are still running and which have finished.

```
[20:00:59] (PID: 645229) [☐ BUSY] sleep 10
[20:00:59] (PID: 645232) [☑ ✅ DONE] echo Hello
[20:00:59] (PID: 645234) [☑ ✅ DONE] uname -a
```

### **3️⃣ Clean completed tasks**

```sh
threader clean
```

✅ Removes finished tasks but **keeps active ones**.

### **4️⃣ Kill all running tasks and clear everything**

```sh
threader clear
```

💀 **Instantly stops all background jobs**.

---

## **💡 Why is **`threader`** So Good?**

### **🚀 1. Fully Parallel Execution**

- **Runs multiple commands at once** instead of waiting for each one to finish.
- **The prompt is free** while commands execute.

### **📝 2. Smart Task Tracking**

- **Every task is recorded with:**\
  ✅ **Start time**\
  ✅ **Unique PID (Process ID)**\
  ✅ **Current status (**``** or **``**)**
- **Fast commands like **``** don’t disappear**—they are properly tracked.

### **⚡ 3. Never Misses a Task**

- **No more lost commands due to race conditions.**
- **Ensures all tasks are written to the log file correctly.**
- **Even if you restart your terminal, you can still check **``.

### **💎 4. Simple and Intuitive Syntax**

- Uses `++` as a **natural separator** between commands.
- `threader list` is like a **mini task manager** in your terminal.

### **🔥 5. Lightweight and Fast**

- **No dependencies needed**—pure Python.
- Works instantly on **Linux & macOS**.

---

## **🛠️ Installation**

### **1️⃣ Make it a system-wide tool:**

```sh
chmod +x threader
sudo mv threader /usr/local/bin/
```

### **2️⃣ Now you can use it like any command-line tool!**

```sh
threader ping -c 4 google.com ++ sleep 5 ++ echo Task Done
```

---

## **🎯 Final Thoughts**

✅ `threader` is **a must-have for multitasking in the terminal**.\
✅ Handles **long-running and instant tasks** **without losing track**.\
✅ **Lets you check progress anytime**, **clean finished jobs**, and **kill everything if needed**.\
✅ **Lightweight, efficient, and works like magic.**

🚀 **Now you can run multiple commands in parallel, track them, and stay productive—without cluttering your terminal!** 🎯
