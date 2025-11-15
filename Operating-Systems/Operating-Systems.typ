#import "@preview/ilm:1.4.1": *
#import "@preview/physica:0.9.5": *
#import "@preview/thmbox:0.2.0": *
#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node, shapes
#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.8": *
#show: codly-init

#codly(languages: codly-languages, number-format: none, zebra-fill: none)

#show: thmbox-init(counter-level: 2)
#set text(lang: "en")
#set figure(numbering: none)
#show figure.where(kind: "thmbox"): set block(breakable: true)

#let definition-counter = counter("definition")
#show: sectioned-counter(definition-counter, level: 2)
#let definition = definition.with(counter: definition-counter)
#let problem = theorem.with(variant: "", numbering: none)
#let solution = proposition.with(variant: "", numbering: none)

#show: ilm.with(
  title: [Operating Systems],
  author: "Surendra Nagar",
  abstract: [],
)

= Overview of Operating Systems

== Computer System Operation

A modern general-purpose computer system consists of $>1$ CPUs and a number of device controllers connected to a common bus. Each device controller is in charge of a particular device type, such as a disk drive or a network interface. The CPU and device controllers can execute concurrently#footnote[There is also a memory controller which synchronizes access to the main memory], competing for memory cycles, and the device controllers can operate independently of the CPU.

#definition[Bootstrap Program][
  This is a small program that initializes the system and loads the operating system kernel into memory. It is typically stored in ROM and is executed when the computer is powered on or reset.
]
#definition[Interrupt][
  An interrupt is a signal to the processor emitted by hardware or software indicating an event that needs immediate attention. When the CPU receives an interrupt, it temporarily halts its current activities, saves its state, and executes a special routine called an interrupt handler to address the event.
]
Instead of polling for events, which can waste CPU cycles, interrupts allow the CPU to be more efficient by only responding to events as they occur.

#figure(
  image("imgs/Interrupt-Timeline.png"),
  caption: [Interrupt Timeline],
)
When an interrupt occurs, it transfers control to the interrupt service routine (generally through the interrupt vector table) which contains the addresses#footnote[The CPU loads the ISR address into the _program counter_ and starts executing it] of all the service routines for different interrupt types.
The CPU preserves its state by saving the program counter and other registers onto the stack before executing the interrupt handler.
#figure(
  image("imgs/Interrupt-Driven-IO-Cycle.png"),
  caption: [Interrupt-Driven I/O Cycle],
)

There is also a hardware device, *timer*, built into the CPU that generates interrupts at fixed or programmable intervals. It lets the OS regain control of the CPU after a set period, preventing any single process from monopolizing the CPU.

== Storage Structure

#figure(
  image("imgs/Storage-Device-Hierarchy.png", height: 30%, fit: "contain"),
  caption: [Storage Device Hierarchy],
)

The main memory#footnote[It is random access, volatile] is the only large storage area that the CPU can access directly. Secondary storage devices, such as hard drives and SSDs, are used to store data and programs that are not currently in use. These devices are slower to access than main memory, so the operating system must manage the transfer of data between main memory and secondary storage efficiently.

The most common secondary storage devices are magnetic disks, optical discs, and solid-state drives (SSDs). *Hard Disk Drives (HDDs)* are rigid metal or glass platters coated with magnetic recording material, and they use magnetic heads to read and write data. A disk surface is divided into concentric circles called tracks, which are further divided into sectors. The disk controller manages the reading and writing of data to and from the disk.

#definition[Direct Memory Access][
  It is a feature that allows certain hardware subsystems to read/write directly to or from the main memory without involving the CPU, thereby improving data transfer rates and freeing up CPU resources for other tasks.
]

#definition[Caching][
  Caching is a technique used to store frequently accessed data in a smaller, faster storage location (the cache) to improve overall system performance. When the CPU needs to access data, it first checks the cache; if the data is found (a cache hit), it can be retrieved more quickly than if it had to be fetched from the slower main memory or secondary storage. If the data is not found in the cache (a cache miss), it is retrieved from the slower storage and may be stored in the cache for future access.
]

== Input-Output Structure

#grid(
  columns: 2,
  gutter: 10pt,
  figure(
    image("imgs/Working-IO-Operation.png"),
    caption: [Working of an I/O Operation],
  ),
  [
    A large portion of the OS is devoted to managing I/O devices#footnote[Storage is also a type of I/O device] and operations. This includes device drivers, which are specialized software components that allow the OS to communicate with hardware devices. Device drivers provide a standard interface for the OS to interact with different types of hardware, abstracting the details of the hardware implementation. Each device controller, maintains a local buffer storage and a set of special registers, is in charge of a specific type of device. The CPU communicates with the device controller by reading and writing to these special registers.
  ],
)

== Computer System Architecture

Computer systems can be classified on the basis of the number of general-purpose processors:
- *Single Processor Systems:* These systems have one CPU that executes all tasks. They are simpler and easier to manage but may become bottlenecks for performance as the number of tasks increases.
- *Multiprocessor/Parallel/Tightly Coupled Systems:* These systems have multiple CPUs that can execute tasks concurrently, improving performance and responsiveness. They share a common memory and are connected by a bus or interconnection network. Multiprocessor systems can be further classified into symmetric multiprocessing (SMP) and asymmetric multiprocessing (AMP) systems.
  - *Symmetric Multiprocessing (SMP):* In SMP systems, all processors have equal access to memory and I/O devices, and they share the same operating system instance. This allows for better load balancing and resource utilization.
  - *Asymmetric Multiprocessing (AMP):* In AMP systems, each processor is assigned a specific task or set of tasks, and they may have their own operating system instances. This can lead to more efficient processing for certain workloads but may require more complex communication mechanisms between processors.
#figure(
  image("imgs/Mutiprocessor-Types.png", height: 15%),
  caption: [Types of Multiprocessor Systems (SMP vs AMP)],
)
- *Clustered Systems:* These systems consist of multiple independent computers (nodes) that work together to perform tasks. They are connected through a high-speed network and can provide improved performance, fault tolerance, and scalability. These systems can be used for load balancing, high availability, and parallel processing and can be structured asymmetrically#footnote[Here, one machine in hot-standby mode while the other runs applications] or symmetrically#footnote[Here, $>2$ machines share the workload equally and monitor each other].

#definition[Dual-Core Design][
  #grid(
    columns: 2,
    gutter: 10pt,
    figure(
      image("imgs/Dual-Core-Design.png", height: 15%),
      caption: [Dual-Core Design],
    ),
    [
      A dual-core design refers to a single processor chip that contains two independent processing units (cores). Each core can execute instructions separately, allowing for true parallelism within a single physical processor. Dual-core (and multi-core) designs improve performance and efficiency by enabling multiple tasks or threads to be processed simultaneously, reducing bottlenecks compared to single-core processors. Modern CPUs often feature multiple cores to better handle multitasking and parallel workloads.
    ],
  )
]

== Operating System Structure

*Multiprogramming* and *Multitasking* are two key concepts in operating system design that aim to improve the utilization of system resources and enhance user experience.

#definition[Multiprogramming][
  It is a technique that allows multiple programs to reside in memory and be executed concurrently by the CPU. The operating system manages the allocation of CPU time and resources to each program, enabling them to share the system's resources effectively. This improves overall system utilization and responsiveness, as the CPU can switch between programs when one is waiting for I/O operations to complete.
]
#definition[Multitasking][
  It is an extension of multiprogramming that allows multiple tasks or processes to be executed concurrently within a single program. The operating system provides the illusion of parallelism by rapidly switching between tasks, giving each one a small time slice of CPU time. This improves responsiveness and user experience, as it allows for smoother interactions and better utilization of system resources.
]

A type of operating system called *Time Sharing Operating System* allows multiple users to interact with the system simultaneously by rapidly switching between them. This gives the illusion of dedicated resources for each user, improving responsiveness and overall user experience.

== Operating System Services

Operating systems provide an environment for the execution of programs and thus, also provides certain services to programs and to the users of those programs. Some of the common services are:
- *User Interface:* The user interface is the means by which users interact with the operating system. It can be command-line based (CLI) or graphical (GUI), allowing users to issue commands, manage files, and control system settings.
- *Program Execution:* It is responsible for loading programs into memory, scheduling their execution, and providing the necessary resources for them to run. This includes managing CPU time, memory allocation, and I/O operations.
- *I/O Operations:* It manages input and output operations for various devices, such as keyboards, mice, displays, and storage devices. It provides a standard interface for device drivers to communicate with hardware and ensures that I/O operations are performed efficiently and securely.
- *Communications:* It facilitates communication between processes, whether they are running on the same machine or across a network. This includes providing mechanisms for inter-process communication (IPC), such as message passing, shared memory, and sockets.
- *Error Detection:* It monitors the system for errors and provides mechanisms for detecting and handling them. This includes checking for hardware failures, memory leaks, and other issues that may affect system stability and performance.
- *Resource Allocation:* It is responsible for managing and allocating system resources, such as CPU time, memory, and I/O devices, to ensure that all processes have the resources they need to execute efficiently. This includes implementing scheduling algorithms, memory management techniques, and I/O management strategies.

#figure(
  image("imgs/Operating-System-Services.png"),
  caption: [Operating System Services],
)

*File Management System* is a crucial component of an operating system that provides a way to store, organize, and manage data on storage devices. It offers a hierarchical structure for organizing files and directories, allowing users to easily access and manipulate their data. The file management system is responsible for tasks such as file creation, deletion, reading, writing, and permissions management. It also abstracts the details of the underlying storage hardware, providing a consistent interface for applications to work with files.

*Protection and Security* are essential aspects of an operating system that ensure the integrity, confidentiality, and availability of data and resources. This includes implementing user authentication, access control mechanisms, and encryption to protect sensitive information from unauthorized access and attacks. *Protection* is any mechanism for controlling access of processes or user resources defined by the OS. *Security* is the defence of the system against internal and external attacks.

#definition[Program][
  A program is a set of instructions that a computer can execute to perform a specific task. It is typically written in a high-level programming language and must be translated into machine code before it can be run by the CPU.
]
#definition[Process][
  A process is an instance of a program in execution. It includes the program code, its current activity, and the resources allocated to it, such as memory and file handles. The operating system manages processes to ensure that they have the necessary resources and can execute concurrently without interfering with each other.
]
Thus, a program is a passive entity while a process is an active entity that is being executed by the CPU. A single program can have multiple processes running simultaneously, each with its own state and resources.

The OS is responsible for creating and deleting both user and system processes, scheduling their execution, and providing mechanisms for inter-process communication and synchronization. It also manages the resources allocated to each process, ensuring that they do not interfere with each other and that the system remains stable and responsive.

== User Operating System Interface

There are two approaches to user operating system interfaces:
- *Command Line Interface:* A command line interface (CLI) allows users to interact with the operating system by typing commands into a text-based terminal. Users can execute programs, manage files, and perform system tasks by entering specific commands and parameters. While CLIs can be powerful and flexible, they often require users to remember command syntax and options.
- *Graphical User Interface:* A graphical user interface (GUI) allows users to interact with the operating system through graphical elements such as windows, icons, and menus. GUIs are generally more user-friendly and intuitive than CLIs, making them accessible to a broader range of users. However, they may require more system resources and can be less efficient for advanced users who prefer keyboard shortcuts and command-line tools.
Now-a-days, we also have *touchscreen interfaces* which are based on actions and selections and do not require the mouse.

== Dual Mode Operation

Modern CPUs support two modes of operation:
- *User Mode:* In user mode, the executing code has limited access to system resources and cannot directly interact with hardware or reference memory locations used by the operating system. This mode is designed to protect the system from errant or malicious programs.
- *Kernel Mode:* In kernel mode, the executing code has unrestricted access to all system resources and can directly interact with hardware. This mode is used by the operating system to perform critical tasks and manage system resources.

The *mode bit* in the CPU indicates the current mode, $0$ for kernel mode and $1$ for user mode. When executing OS kernel instructions (system calls, interrupts, exceptions), the CPU switches from user mode to kernel mode. When the OS finishes executing, it switches back to user mode. This dual-mode operation ensures that user programs cannot directly access critical system resources, providing a layer of protection and stability for the operating system.
#figure(
  image("imgs/Kernel-Mode-Bit.png"),
  caption: [Mode Bit Operation],
)

#definition[System/Monitor Call][
  It is a mechanism that allows user programs to request services from the operating system's kernel. System calls provide a controlled interface for accessing hardware and system resources, ensuring that user programs operate within the constraints of the operating system's security and protection mechanisms.
]
These are typically written in a high-level programming language like `C`, `C++` and are accessed by programs via a high-level _Application Programming Interface (API)_. We have `Win32` for Windows and `POSIX` for Unix-like systems.

There are essentially 5 groups of system calls:
- *Process Control:* These system calls manage processes, including creating, terminating, and synchronizing processes.
- *File Management:* These system calls handle file operations, such as creating, deleting, reading, and writing files.
- *Device Management:* These system calls manage device operations, including requesting and releasing device access.
- *Information Maintenance:* These system calls provide information about the system, such as system time and process status.
- *Communication:* These system calls facilitate communication between processes, including message passing and shared memory.

These system calls are assigned a number which is used by the kernel to identify the specific service being requested. When a user program makes a system call, it provides this number along with any necessary parameters, allowing the kernel to execute the appropriate service.
There are three main methods of passing arguments to the OS:
- The simplest is to pass the parameters in a register
- The parameters can be stored in a block/table/in memory and the address of the block is passed in a register
- The parameters can be pushed on the stack and popped off by the OS

== Virtualization

#definition[Virtualization][
  It is a technology that allows you to run multiple isolated operating systems (OSes) or applications on the same physical hardware simultaneously. It works by creating virtual machines (VMs), each of which acts like a separate computer, but they share the same underlying hardware resources.
]
A *hypervisor* (or virtual machine monitor VMM) sits between the hardware and the OS which allocates CPU, memory, storage and I/O resources to each VM as needed, creating the illusion that each VM has its own dedicated hardware.
#figure(
  image("imgs/Virtualization.png", height: 25%),
  caption: [Virtualization Architecture],
)

*Emulation* is related but instead of sharing the host CPU instruction set, emulation mimics different hardware or architectures in software. E.g. running a Nintendo console game on a PC.

== System Programs

These provide a convenient environment for users to interact with the operating system and perform various tasks. System programs include:

- *File Management Utilities:* Tools for managing files and directories, such as creating, deleting, and organizing files.
- *Status Information:* Programs that provide information about the system's current state, including resource usage, system load, and active processes.
- *File Modification:* Text editors and other tools for creating and modifying files.
- *Programming-Language Support:* Tools and libraries that assist with programming in various languages, including compilers, interpreters, and debuggers.
- *Program Loading and Execution:* Utilities for loading and executing programs, including linkers and loaders.
- *Communications:* Tools for managing network connections and data transfer between systems.

These programs enhance the functionality of the operating system and provide users with the tools they need to effectively manage their computing environment. Some of these are simply user interfaces to the underlying system calls and services provided by the operating system while some are pretty complex.

=== Linker and Loader

#definition[Linker][
  A linker is a system program that takes one or more object files generated by a compiler and combines them into a single executable file. It resolves references between different object files, such as function calls and variable accesses, and assigns final memory addresses to code and data segments.
]

It produces `.o` files which reference functions/variables defined in other object files. Moreover, say we call `printf` in our code, the linker will resolve this reference to the actual implementation of `printf` in the C standard library. This is done in one of two ways:
- *Static Linking:* The linker copies all necessary library functions into the executable at compile time, resulting in a larger executable file but with no external dependencies at runtime. These are `.a` files on Unix-like systems.
- *Dynamic Linking:* The linker creates references to shared library functions, which are resolved at runtime. This results in smaller executable files and allows for easier updates to shared libraries. These are `.so` files on Unix-like systems.

#definition[Loader][
  A loader is a system program that loads an executable file into memory and prepares it for execution. It allocates memory for the program's code and data segments, resolves any remaining references, and sets up the program's execution environment.
]

#grid(
  columns: 2,
  gutter: 10pt,
  figure(
    image("imgs/Linker-Loader.png"),
    caption: [Role of Linker and Loader],
  ),
  [
    It is responsible for loading the program into memory, setting up the stack and heap, and transferring control to the program's entry point. The loader may also perform additional tasks such as dynamic linking of shared libraries and relocation of code and data segments.

    This kinda answers why applications are OS specific. The compiled code contains system calls and library calls specific to the OS, and the linker/loader must be able to handle these appropriately.
  ],
)

== Design and Implementation

Beyond the choice of hardware architecture and the type of system, the requirements are hard to specify. However, there are two major requirements:
- *User Goals:* The OS should be convenient to use, easy to learn, reliable, safe and fast.
- *System Goals:* The OS should be easy to design, implement and maintain, flexible,

There is also an important principle to seperate mechanisms from policies, i.e. the what needs to be done (policy) should be distinct from how it is done (mechanism) since it allows for maximum flexibility and adaptability in the system design.

After the OS is designed, it must be implemented and tested to ensure that it meets the specified requirements and performs well in real-world scenarios. It was earlier written in assembly language but now-a-days, it is mostly written in `C` with some parts in assembly language for low-level hardware interactions. Systems programs are written in high-level languages like `C`, `C++`, `Python` etc. Using higher-level languages make it easier to write, read, and maintain the code but can cause it to get slow.

== Structures of Operating System

#grid(
  columns: 2,
  gutter: 5pt,
  figure(
    image("imgs/MS-DOS-OS-Structure.png"),
    caption: [Structure of the MS-DOS Operating System],
  ),
  [This is a very simple layered structure where each layer is built on top of the one below it. It works but just works. There is not much abstraction or separation of concerns. It is almost a single layer since all the layers interact directly with the base hardware. The separation is so bad that applications run in the same address space as the OS.],
)

=== Monolithic Structure

#grid(
  columns: 2,
  gutter: 10pt,
  [
    #figure(
      image("imgs/Unix-System-Structure.png"),
      caption: [Structure of the Unix Operating System],
    )
    The entire OS works in kernel mode as a single large program called the _kernel_. Since there is one large kernel, all the OS services can call each other and share data easily. Since everything works in kernel mode, system calls and functions are direct and thus very efficient. The components can communicate directly using function calls. However, this also means that a bug in any part of the kernel can crash the entire system. Moreover, it is difficult to maintain and extend since any change requires recompiling and relinking the entire kernel.
  ],
  figure(
    image("imgs/Linux-System-Structure.png"),
    caption: [Structure of the Linux Operating System],
  ),
)

=== Layered Structure

#grid(
  columns: 2,
  gutter: 10pt,
  [
    #figure(
      image("imgs/Layered-Structure.png"),
      caption: [Layered Operating System Structure],
    )
  ],
  [
    The entire OS is divided into layers, each built on top of the lower layers.\
    The layers are designed such that each layer only interacts with the layer directly below it.\
    This provides a clear separation of concerns and makes it easier to design, implement, and maintain the OS.\
    However, it can be less efficient than a monolithic structure since each layer must communicate through well-defined interfaces, which can introduce overhead.
  ],
)
Modern OS designs combine the layered approach with other structures to balance modularity and performance. It was used in `THE` OS#footnote[Made by the guy Dijkstra], `MULTICS` etc.

=== Microkernel Structure

This is essentially the opposite of the monolithic structure. The core functionality of the OS is implemented in a small kernel that runs in kernel mode, while other services run in user mode as separate processes (also called *servers*). The microkernel provides basic services such as inter-process communication, memory management, and process scheduling, while other services such as file systems, device drivers, and network protocols are implemented as user-space processes.

#grid(
  columns: 2,
  gutter: 10pt,
  figure(
    image("imgs/Microkernel-Structure.png"),
    caption: [Microkernel Operating System Structure],
  ),
  [
    It provides better modularity and separation of concerns, making it easier to maintain and extend the OS.\
    It is more reliable and secure since a bug in a user-space service cannot crash the entire system.\
    It is portable across different hardware architectures since the microkernel can be designed to be hardware-independent.\
  ],
)
However, it can be less efficient than a monolithic structure since communication between the microkernel and user-space services can introduce overhead since more context switches are required. It is used in `MINIX`, `QNX`, `L4` etc. `Mach` is a popular microkernel that forms the basis for the `XNU` kernel used in macOS and iOS.

=== Hybrid Structure

This structure combines elements of both monolithic and microkernel designs. The core functionality of the OS is implemented in a small kernel that runs in kernel mode, while other services run in user mode as separate processes. However, some services may be implemented as part of the kernel for performance reasons.

Linux and Solaris kernels are monolithic but have some modules that can be loaded and unloaded at runtime, making them somewhat modular. Windows NT uses a hybrid approach with a microkernel-like architecture for core services and monolithic components for performance-critical tasks.

#definition[Module][
  It is a separate, loadable part of the kernel that can be independently developed, tested, loaded, or unloaded at runtime. They provide a modular approach to OS design, combining benefits of both monolithic and microkernel structures.
]

== Operating System Generation

It refers to the process of creating a customized operating system from a general-purpose OS codebase for a specific computer system or hardware configuration. It is basically "compiling" + "configuring" + "tailoring" an OS so that works efficiently on a specific hardware setup.

Since OS do not come as one single prebuilt binary, they come as a collection of programs, modules and configuration options which during system generation (*sysgen*), the OS builder (*installer*) selects which modules to include, what hardware support is required and what policies to use. The system then assembles/compiles these into an executable kernel image.

- *Specification:* Administrator specifies system needs (CPU type, memory size, device types, performance requirements)
- *Selection:* OS modules are selected accordingly
- *Compilation/Assembly:* The chosen modules are compiled and linked
- *Generation:* The final OS image (kernel  + utilities) are built
- *Bootstrapping:* The OS image is placed on a boot device to start the system

To build and boot a Linux system, the following steps are typically followed:
+ Download Linux source code
+ Configure the kernel using `make menuconfig`
+ Compile the kernel using `make`
  - This produces the kernel image (`vmlinuz`) and modules
  - Compile the kernel modules using `make modules`
  - Install the modules using `make modules_install`
+ Install the kernel using `make install`

== System Boot

The procedure of starting a computer and loading the kernel is called *booting* or *bootstrapping*. On most systems, a small program called the *bootstrap loader*#footnote[This is loaded into the memory by the BIOS (Basic Input/Output System) or UEFI (Unified Extensible Firmware Interface) firmware] is stored in ROM or EEPROM. When the computer is powered on or reset, the CPU starts executing this program, which initializes the hardware and loads the operating system kernel into memory.

The BIOS loads the bootstrap loader which loads _GRUB_ (GRand Unified Bootloader) which is a popular bootloader used in many Linux systems. It displays a menu of available operating systems and allows the user to select which one to boot. GRUB then loads the selected OS kernel into memory and transfers control to it.

After the full bootstrap program has been loaded, it can traverse the file system to find the kernel, load it into memory, and start its execution. It is at this time that the system is said to be "booted" or "started up".

== Operating System Debugging

#footnote[Some bitch Kernighan said "Debugging is twice as hard as writing the code in the first place. Therefore, if you write the code as cleverly as possible, you are, by definition, not smart enough to debug it." makes sense but why tho]It is the process of finding and fixing errors (bugs, crashes, hangs, race conditions, memory leaks) in an operating system kernel or its components. Since the OS itself manages hardware, memory, processes, and I/O, debugging it often requires special tools, techniques, and environments.

The OS generates _log files_ containing error information. Application failures can generate _core dump_ files capturing memory state at the time of the crash. OS failures can generate _crash dump_ files for post-mortem analysis containing kernel memory.

We can use it for performance tuning by analyzing the logs and dumps to identify bottlenecks, resource contention, and other issues affecting system performance. *Profiling* tools can help visualize and understand resource usage patterns.

*Tracing* means monitoring system calls, interrupts, and other events to understand system behavior. Tools like `strace` (for Linux) can trace system calls made by a process, while `dtrace` (for Solaris, macOS) provides dynamic tracing capabilities for the entire system. `gdb` is a source-level debugger that allows you to inspect the state of a running program, set breakpoints, and step through code.

= Process Management

A process is a program in execution. It is an active entity, as opposed to a program which is a passive entity. A process needs certain resources like CPU time, memory, files and I/O devices to accomplish its task. These resources are allocated to the process by the operating system. (Already defined above)

A process has multiple components:
- *Program Code (Text Section):* This is the executable code of the program.
- *Program Counter:* This register indicates the address of the next instruction to be executed for this process.
- *Stack:* This section contains temporary data such as function parameters, return addresses, and local variables.
- *Data Section:* This area contains global variables and static variables that are used by the program.
- *Heap:* This is a region of memory that is dynamically allocated during the process's runtime for variables and data structures.

#figure(
  image("imgs/Process-State-Diagram.png"),
  caption: [Process State Diagram],
)

A process can be in one of the following states:
- *New:* The process is being created.
- *Ready:* The process is waiting to be assigned to a CPU for execution.
- *Running:* The process is currently being executed by the CPU.
- *Waiting (Blocked):* The process is waiting for some event to occur (like I/O completion or a signal).
- *Terminated:* The process has finished execution.

#grid(
  columns: (1fr, 2fr),
  gutter: 10pt,
  figure(
    image("imgs/Process-Control-Block.png"),
    caption: [Process Control Block (PCB)],
  ),
  [
    Each process is represented in the OS by a data structure called the *Process Control Block (PCB)* which contains information about the process, including:
    - *Process State:* The current state of the process (new, ready, running, waiting, terminated).
    - *Process ID (PID):* A unique identifier for the process.
    - *Program Counter:* The address of the next instruction to be executed.
    - *CPU Registers:* The contents of the CPU registers when the process is not running.
    - *Memory Management Information:* Information about the process's memory allocation, such as base and limit registers, page tables, or segment tables.
    - *Accounting Information:* Information about the CPU usage, execution time, and other resource usage statistics.
    - *I/O Status Information:* Information about the process's I/O devices, open files, and other I/O-related data.
  ],
)

A process is represented by the C struct, `task_struct` in Linux.
```c
struct task_struct {
    volatile long state;       // Process state
    struct thread_info *thread_info; // Thread information
    struct task_struct *parent; // Parent process
    pid_t pid;                // Process ID
    unsigned int flags;       // Process flags
    struct mm_struct *mm;     // Memory management information
    struct files_struct *files; // Open files
    struct signal_struct *signal; // Signal handling information
    struct list_head tasks;   // List of all processes
    // ... (many more fields)
};
```

#definition[Thread#footnote[Will know more later]][
  A thread is the smallest unit of execution within a process. It is a sequence of executable instructions that can be scheduled and executed independently by the CPU. A process can contain multiple threads, which share the same memory space and resources of the parent process but have their own program counter, stack, and registers.
]

== Process Scheduling

This is the activity of the OS that handles the selection of processes for execution on the CPU. The goal of process scheduling is to maximize CPU utilization, ensure fairness among processes, provide a responsive user experience and have minimum waiting and turnaround times.

We have three types of schedulers:
- *Long-Term Scheduler (Job Scheduler):* It selects processes from the pool of new processes and loads them into memory for execution. It controls the degree of multiprogramming by determining how many processes are allowed to be in memory at any given time. It is invoked infrequently, typically when a new process is created or an existing process terminates.
- *Medium-Term Scheduler:* It is responsible for temporarily removing processes from memory (swapping out) and later bringing them back into memory (swapping in) to manage the degree of multiprogramming and improve system performance. It is invoked when the system is under heavy load or when a process has been waiting for a long time.
- *Short-Term Scheduler (CPU Scheduler):* It selects processes from the pool of ready processes and allocates the CPU to one of them. It is invoked frequently, typically every few milliseconds, to ensure that the CPU is always busy executing processes.

#grid(
  columns: 2,
  gutter: 10pt,
  figure(
    image("imgs/Process-Scheduling-Queues.png"),
    caption: [Process Scheduling],
  ),
  [
    For process scheduling, we maintain two queues:
    - *Ready Queue:* This queue contains all processes that are in the ready state and are waiting to be assigned to a CPU for execution.
    - *Waiting Queue:* This queue contains all processes that are in the waiting state and are waiting for some event to occur (like I/O completion or a signal).
  ],
)

#definition[Context Switch][
  It is the process of saving the state of a currently running process and restoring the state of a previously suspended process. This allows the CPU to switch between different processes, enabling multitasking and efficient use of system resources.
]
When a context switch occurs, the OS saves the current process's state (including the program counter, CPU registers, and memory management information) in its PCB and loads the state of the next process to be executed from its PCB. This involves updating the CPU registers, program counter, and memory management information to reflect the new process's state.

== Operations on Processes

=== Process Creation

#grid(
  columns: 2,
  gutter: 10pt,
  figure(
    image("imgs/Process-Tree.png"),
    caption: [Process Tree],
  ),
  [
    A process may create multiple processes, which are called its *children*. The creating process is called the *parent*. The relationship between processes forms a tree structure, with the initial process (often called `init` in Unix-like systems) as the root.
  ],
)
Processes are identified using a unique integer called the *Process ID (PID)*. Each process also has a *Parent Process ID (PPID)* that identifies its parent process.

In terms of execution, a new process can either continue to execute concurrently with the parent or the parent can wait until the child process terminates. In terms of address space, a new process can either share the parent's address space or have a separate copy of it.

In Unix-like systems, a new process is created using the `fork()` system call, which creates a copy of the parent process. The new process can then use the `exec()` family of system calls to replace its address space with a new program. The parent process can use the `wait()` system call to wait for the child process to terminate and retrieve its exit status.
#grid(
  columns: 3,
  gutter: 2pt,
  [
    #codly(header: [Using `fork()`])
    ```c
    pid_t pid = fork();
    if (pid < 0) { perror("fork"); return EXIT_FAILURE; }
    if (!pid) printf("Child PID:%d\n", getpid());
    else printf("Parent PID:%d, Child PID:%d\n", getpid(), pid);
    return EXIT_SUCCESS;
    ```
  ],
  [
    #codly(header: [Using `exec()`])
    ```c
    pid_t pid = fork();
    if (pid < 0) { perror("fork"); return EXIT_FAILURE; }
    if (!pid) { execlp("ls","ls","-l",(char*)NULL); perror("execlp"); exit(EXIT_FAILURE); }
    printf("Parent PID:%d, Child PID:%d", getpid(), pid);
    wait(NULL); return EXIT_SUCCESS;
    ```
  ],
  [
    #codly(header: [Using `wait()`])
    ```c
    pid_t pid = fork();
    if (pid < 0) { perror("fork"); return EXIT_FAILURE; }
    if (!pid) { printf("Child PID:%d\n", getpid()); sleep(2); printf("Child exit.\n"); }
    else { printf("Parent waiting...\n"); wait(NULL); printf("Child done.\n"); }
    return EXIT_SUCCESS;
    ```
  ],
)

=== Process Termination

- *Voluntary Termination:* A process executes its last statement and then explicitly calls the `exit()` system call. Now, the process returns a status code (this is passed using the `wait()` system call that the parent may invoke) to its parent.
- *Resource Allocation:* Once a process exists, the memory (stack, heap, code) is freed, open files, I/O devices and locks are released and its PCB is marked as terminated.
- *Parent-Initiated Termination:* This happens when the parent does not wait for the child to finish but _forces_ termination. The parent uses an `abort()` system call. This could happen when the child exceeds resource limits, the child's work is no longer needed or the parent is exiting and the OS does not allow children to continue alone.
- *Cascading Termination:* When a parent is terminated, then all its children (grand-children and so on) must also be terminated#footnote[This occurs in some OS]. This is initiated by the OS to prevent orphaned subtrees of processes.
- *Waiting for Child Termination:* The parent may call `wait()` to pause until a child finishes, collect the child's exit status and reclaim the child's PCB entry. `wait()` also returns the PID of the terminated child.

#definition[Zombie Process][
  It is a process that has completed execution but still has an entry in the process table. This occurs when the parent process has not yet read the exit status of the terminated child process using the `wait()` system call. Zombie processes do not consume system resources like CPU or memory, but they do occupy a slot in the process table, which can lead to resource exhaustion if many zombies accumulate.
]
#definition[Orphan Process][
  It is a process whose parent process has terminated or exited before the child process. In most operating systems, orphan processes are automatically adopted by a special system process (like `init` in Unix-like systems) to ensure that they can still be properly managed and terminated when they complete their execution.
]

== Interprocess Communication

The processes executing concurrently within a system may be:
#definition[Independent Process][
  It is a process that does not share data or resources with other processes. It operates in its own memory space and does not communicate or synchronize with other processes.
]
#definition[Cooperating Process][
  It is a process that shares data or resources with other processes. It can communicate and synchronize with other processes to achieve a common goal or perform a specific task.
]

We require an environment that allows process cooperation for _information sharing_, _computation speedup_, _modularity_ and _convenience_. There are two main models for interprocess communication (IPC), _shared memory_ and _message passing_.

=== Shared Memory

#grid(
  columns: (1fr, 2fr),
  gutter: 10pt,
  figure(
    image("imgs/Shared-Memory.png"),
    caption: [Shared Memory IPC],
  ),
  [
    Here, processes share a region of memory. The kernel is used to setup the shared memory region but dips and communication happens without kernel intervention. Thus, this is the fastest form of IPC. Normally, the kernel prevents getting in another process's pants but if the processes consent to share memory, the kernel allows it. This method is useful for processes that need to exchange large amounts of data quickly.
  ],
)

#problem[Producer-Consumer Problem#footnote[There is also another variation which uses an unbounded buffer]][
  We have a finite buffer of size $N$ shared by two types of processes:
  - *Producer* processes generate items and place them in the buffer.
  - *Consumer* processes remove items from the buffer and consume them.
  Constraints:
  - The producer must wait if the buffer is full before inserting a new item
  - The consumer must wait if the buffer is empty before removing an item
  - Access to the buffer must be mutually exclusive, i.e. no two processes may access it simultaneously
  The _goal_ is to ensure correct synchronization so that items are produced and consumed in order, without overwriting data or consuming invalid data.
]

#solution[Using Two Pointers][
  Consider the shared data:
  ```c
  #define BUFFER_SIZE 10
  item buffer[BUFFER_SIZE];
  int in = 0;   // Index where the producer will place the next item
  int out = 0;  // Index where the consumer will take the next item
  ```
  #grid(
    columns: 2,
    gutter: 10pt,
    [
      The producer process:
      ```c
      item next_produced;
      while (true) {
        /* Produce an item in next_produced */
        while ((in + 1) % BUFFER_SIZE == out) ; // Wait if buffer is full
        buffer[in] = next_produced;            // Place item in buffer
        in = (in + 1) % BUFFER_SIZE;           // Update in index
      }
      ```
    ],
    [
      The consumer process:
      ```c
      item next_consumed;
      while (true) {
        while (in == out) ;                     // Wait if buffer is empty
        next_consumed = buffer[out];            // Remove item from buffer
        out = (out + 1) % BUFFER_SIZE;          // Update out index
        /* Consume the item in next_consumed */
      }
      ```
    ],
  )
  Here, we can only use `BUFFER_SIZE - 1` slots to distinguish between full and empty states#footnote[This is a common technique in ring buffer implementations]. However, there are other pressing issues with this solution:
  - Both processes may simultaneously check the buffer state and enter the critical section and cause race conditions.
  - The busy-waiting wastes CPU cycles.
  - It works only for one producer and one consumer.
]
We can improve slightly on this solution by being able to use the entire buffer by having an integer count of the number of items in the buffer. However, this does not solve the other issues.
#pagebreak()
#solution[Using `counter`][
  #grid(
    columns: 2,
    gutter: 10pt,
    [
      The producer process:
      ```c
      item next_produced;
      while (true) {
        /* Produce an item in next_produced */
        while (counter == BUFFER_SIZE) ; // Wait if buffer is full
        buffer[in] = next_produced;     // Place item in buffer
        in = (in + 1) % BUFFER_SIZE;    // Update in index
        counter++;                        // Increment count
      }
      ```
    ],
    [
      The consumer process:
      ```c
      item next_consumed;
      while (true) {
        while (counter == 0) ;            // Wait if buffer is empty
        next_consumed = buffer[out];     // Remove item from buffer
        out = (out + 1) % BUFFER_SIZE;   // Update out index
        counter--;                         // Decrement count
        /* Consume the item in next_consumed */
      }
      ```
    ],
  )
  This infact brings us *race conditions* on the `counter` variable. Consider the following implementation for incrementing and decrementing the counter:
  #grid(
    columns: 2,
    gutter: 10pt,
    [
      ```c
      register1 = counter
      register1 = register1 + 1
      counter = register1
      ```
    ],
    [
      ```c
      register2 = counter
      register2 = register2 - 1
      counter = register2
      ```
    ],
  )
  Say the execution order is (with count = 5 initially):
  + Producer: `register1 = counter` (register1 = 5)
  + Consumer: `register2 = counter` (register2 = 5)
  + Producer: `register1 = register1 + 1` (register1 = 6)
  + Consumer: `register2 = register2 - 1` (register2 = 4)
  + Producer: `counter = register1` (counter = 6)
  + Consumer: `counter = register2` (counter = 4)
  The final value of `counter` is 4 instead of 5, which is incorrect
]

=== Message Passing

#grid(
  columns: (1fr, 2fr),
  gutter: 10pt,
  figure(
    image("imgs/Message-Passing.png"),
    caption: [Message Passing IPC],
  ),
  [
    Here, processes communicate by sending and receiving messages. The kernel is involved in the communication, which can introduce some overhead. This method is useful for processes that do not share a common memory space or are on different machines.

    This IPC facility provides two operations:
    - *Send(message):* This operation allows a process to send a message to another process
    - *Receive(message):* This operation allows a process to receive a message from another process
  ],
)
#pagebreak()
The message can either be:
- *Fixed Size:* The message has a predetermined size, which simplifies memory management but can lead to wasted space if the message is smaller than the allocated size.
- *Variable Size:* The message can have a variable size, which allows for more flexibility but requires more complex memory management.

A communication link must be established between the sender and receiver processes. It can be implemented physically using shared memory, hardware bus or network connection. The methods for logically implementing a link are: (there are several issues like _naming_, _synchronization_ and _buffering_)

==== Naming

The processes that wish to communicate must be able to refer to each other.

Using *Direct Communication*, each processes must explicitly name the recipient or sender of the message. The communication link is established automatically between the two processes. The properties are:
- Each process must have a unique identifier (ID)
- A link is associated with exactly one pair of communicating processes
- The link may be unidirectional or bidirectional
This scheme exhibits symmetry in addressing, i.e. both sender and receiver must name each other to communicate. There is also another variant where only the sender names the receiver, which is asymmetric.

The disadvantage in both of these is the limited modularity of the resulting process definitions since changing the name of a process requires changing the code of all other processes that communicate with it.

Using *Indirect Communication*, messages are sent to and received from mailboxes (also called ports). A mailbox is a logical entity that is identified by a unique ID. A link is established between a pair of mailboxes. The properties are:
- Each mailbox has a unique ID
- Two processes can communicate only if they share a mailbox
- A mailbox is any object into which messages can be placed by a process and from which messages can be removed
- A link may be associated with more than two processes
- A link may be unidirectional or bidirectional
- A mailbox can either be owned by a process or by the OS

Consider a process P1 which sends a message to a mailbox with P2 and P3. If both P2 and P3 try to receive the message, then we have:
- Allow at most one process to receive the message. The other process must wait until a new message is sent to the mailbox.
- Allow a link to be associated with at most two processes. This is like direct communication.
- Allow the system to select arbitrarily which process will receive the message (either P2 or P3). The system may define an algorithm for selecting which process will receive the message (like round robin). The system may identify the receiver to the sender.

==== Synchronization

Communication takes place using `send()` and `receive()` operations. These can be either blocking or non-blocking.
- *Blocking Send:* The sender is blocked until the message is received by the receiver. This is also called synchronous communication.
- *Non-Blocking Send:* The sender sends the message and continues execution. This is also called asynchronous communication.
- *Blocking Receive:* The receiver is blocked until a message is available. If no message is available, the process is put to sleep.
- *Non-Blocking Receive:* The receiver retrieves a message if one is available and continues execution. If no message is available, the process continues without waiting.

==== Buffering

Messages exchanged by processes reside in temporary queues (buffers). These are implemented in three ways:
- *Zero Capacity (Rendezvous):* The queue has no buffer space. A message must be received before the next message can be sent. Both sender and receiver must wait for each other to be ready. This is like blocking send and blocking receive.
- *Bounded Capacity:* The queue has a finite buffer size. If the buffer is full, the sender must wait until space is available. If the buffer is empty, the receiver must wait until a message is available.
- *Unbounded Capacity:* The queue has infinite buffer space. The sender never waits. If the buffer is empty, the receiver must wait until a message is available. This requires dynamic memory allocation.

=== Pipes

It is an IPC mechanism that provides a unidirectional communication channel between two processes. One process writes data into the pipe and another reads from it. Data flows in a first-in-first-out (FIFO) manner. Pipes are commonly used for communication between related processes, such as a parent and child process.

==== Unnamed Pipes

These are created using the `pipe()` system call and are typically used for communication between a parent process and its child processes. They are temporary and exist only as long as the processes are running. E.g. `ls | grep ".c"`, here, the shell internally creates an unnamed pipe to connect the output of `ls` to the input of `grep`.

==== Named Pipes (FIFOs)

These are called FIFOs (First In First Out) and are created using the `mkfifo()` system call or the `mkfifo` shell command. They have a name in the file system and can be used for communication between unrelated processes. Named pipes persist in the file system until they are explicitly deleted. E.g.
```bash
mkfifo mypipe          # Create a named pipe
echo "Hello" > mypipe  # Write to the pipe
cat < mypipe           # Read from the pipe
rm mypipe              # Delete the named pipe
```

== Communications in Client-Server Systems

=== Sockets

#grid(
  columns: 2,
  gutter: 10pt,
  figure(
    image("imgs/Socket.png"),
    caption: [Socket IPC],
  ),
  [
    A socket is an endpoint for communication between two machines. It is a software abstraction that represents a network connection. Sockets provide a way for processes to communicate over a network using standard protocols like TCP (Transmission Control Protocol) and UDP (User Datagram Protocol). It is represented by a file descriptor in the OS and support bidirectional communication. It is identified by an IP address and a port number.
  ],
)

A server process creates a socket, binds it to a specific port, and listens for incoming connections. A client process creates a socket and connects to the server's socket using the server's IP address and port number. Once the connection is established, both processes can send and receive data through the socket. Servers implement specific services (like telnet, FTP, HTTP) and listen to requests on well-known ports#footnote[All ports below 1024 are considered well-known ports and can be used to implement standard services].

=== Remote Procedure Calls (RPC)

It is a communication mechanism that allows a process to invoke a procedure (function) in another address space (commonly on another physical machine). It abstracts the details of the network communication, making it appear as if the procedure is being called locally.

This is how a typical RPC works:
+ Client calls a local stub procedure, passing the required parameters
+ A client stub (auto-generated proxy) takes the function arguments and marshals them (serializes into a byte stream)
+ The client stub sends the request over the network (usually via sockets)
+ The server stub receives the request, unmarshals the arguments back into native data
+ The server executes the actual procedure
+ The result is marshalled and sent back to the client
+ The client stub receives and unmarshals the result
+ The client program continues as if the function was executed locally

== Threads

#grid(
  columns: 2,
  gutter: 10pt,
  figure(
    image("imgs/Single-VS-Multi-Threaded.png"),
    caption: [Thread Structure],
  ),
  [
    #definition[Thread][
      It is the smallest unit of execution within a process. It is a lightweight execution flow#footnote[A process has its own memory space, code, data and resources] inside a process that shares most of the process's resources but has its own program counter, registers and stack. Multiple threads within a process share the same code section, heap and open files and OS resources.
    ]
  ],
)
A thread has the following components:
- *Thread ID:* A unique identifier for the thread within the process.
- *Program Counter:* The address of the next instruction to be executed by the thread.
- *Registers:* The CPU registers used by the thread during its execution.
- *Stack:* A separate stack for each thread to store local variables, function parameters, and return addresses.

The benefits of using threads are:
- *Responsiveness:* In a multi-threaded application, if one thread is blocked (e., waiting for I/O), other threads can continue to execute, improving the overall responsiveness of the application
- *Resource Sharing:* Threads within the same process share the same memory space and resources, making it easier to share data and communicate between threads without the need for complex IPC mechanisms
- *Economy:* Creating and managing threads is generally more efficient than creating and managing processes, as threads have lower overhead in terms of memory, CPU usage and thread switching time#footnote[It has lower overhead than context switching between processes]
- *Scalability:* Multi-threaded applications can take advantage of multi-core processors by distributing threads across multiple CPU cores, improving performance and scalability

=== Multicore/Multiprocessor Programming

The challenges in programming for multicore/multiprocessor systems are:
#columns(2)[
  - Dividing activites
  - Balance
  - Data splitting
  #colbreak()
  - Data dependency
  - Testing and debugging
]

#figure(image("imgs/Parallelism.png"), caption: [Parallelism])
#definition[Parallelism][
  It is the simultaneous execution of multiple tasks or processes to improve performance and efficiency. In a parallel system, multiple processors or cores work together to execute different parts of a program concurrently, allowing for faster completion of tasks.
]
There are two types of parallelism:
#grid(
  columns: 2,
  gutter: 10pt,
  figure(
    image("imgs/Data-Parallelism.png"),
  ),
  figure(
    image("imgs/Task-Parallelism.png"),
  ),
)

#figure(
  image("imgs/Concurrency.png"),
  caption: [Concurrency],
)
#definition[Concurrency][
  It is the ability of a system to handle multiple tasks or processes at the same time, but not necessarily simultaneously. In a concurrent system, multiple tasks may be in progress at the same time, but they may not be executing simultaneously on different processors or cores. Concurrency is often achieved through techniques like time-sharing, where the CPU switches between different tasks rapidly to give the illusion of simultaneous execution.
]

Amdahl's Law gives the theoretical speedup in program execution when part of the program is parallelized.
$
  S = 1/((1 - P) + (P / N))
$


=== Multithreading Models

#definition[User Threads][
  These are managed in the user space by a thread library (`pthreads`) without kernel support. The kernel is unaware of the existence of user threads. Scheduling and context switching is done by the thread library. They are lightweight and have low overhead, but if one thread makes a blocking system call, the entire process is blocked.
]
#definition[Kernel Threads][
  These are managed directly by the OS kernel. The kernel is aware of the existence of kernel threads and schedules them independently. They can take advantage of multiple processors and can make blocking system calls without blocking the entire process. However, they have higher overhead due to kernel involvement in scheduling and context switching.
]

==== Many-to-One Model

#grid(
  columns: (1fr, 2fr),
  gutter: 10pt,
  figure(
    image("imgs/Many-to-One-Model.png"),
    caption: [Many-to-One Model],
  ),
  [
    Here, many user-level threads are mapped to a single kernel thread. The OS sees only one process and is unaware of the multilple threads within it. The thread creation is done entirely in the user space using a thread library. It has fast thread creation and context switching since it does not involve the kernel and is lightweight and portable. However, if one thread makes a blocking system call, the entire process is blocked and is not true parallelism since only one thread can access the kernel at a time. E.g. Solaris Green Threads, GNU Portable Threads.
  ],
)

==== One-to-One Model

#grid(
  columns: (1fr, 2fr),
  gutter: 10pt,
  figure(
    image("imgs/One-to-One-Model.png"),
    caption: [One-to-One Model],
  ),
  [
    Here, each user-level thread is mapped to a separate kernel thread. The OS is aware of all the threads and can schedule them independently. It allows true parallelism since multiple threads can run on multiple processors simultaneously. If one thread makes a blocking system call, other threads can continue to execute. However, it has higher overhead due to kernel involvement in thread management and is limited by the maximum number of threads that can be created by the OS. E.g. Windows, Linux.
  ],
)

==== Many-to-Many Model

#grid(
  columns: (1fr, 2fr),
  gutter: 10pt,
  figure(
    image("imgs/Many-to-Many-Model.png"),
    caption: [Many-to-Many Model],
  ),
  [
    Here, many user-level threads are mapped to a smaller or equal number of kernel threads. The OS is aware of the kernel threads and can schedule them independently. It allows true parallelism and can handle blocking system calls without blocking the entire process. It provides flexibility in managing the number of threads and can optimize resource usage. However, it has higher complexity in implementation and may have overhead due to the mapping between user and kernel threads. E.g. Solaris Threads.
  ],
)

==== Two-Level Model

#grid(
  columns: (1fr, 2fr),
  gutter: 10pt,
  figure(
    image("imgs/Two-Level-Model.png"),
    caption: [Two-Level Model],
  ),
  [
    This is the same as the many-to-many model, but it allows a user thread to be bound to a specific kernel thread. This provides the benefits of both models, allowing for true parallelism and handling blocking system calls while also providing flexibility in thread management.
  ],
)

==== Implicit Threading

This is a high-level abstraction where the compiler or runtime system automatically manages thread creation, scheduling, and synchronization. The programmer does not have to explicitly create or manage threads. This model is often used in functional programming languages and parallel programming frameworks. There are five common approaches:
- *Thread Pools:* A pool of worker threads is created at the start of the program. Tasks are assigned to available threads from the pool, reducing the overhead of thread creation and destruction.
- *Fork-Join:* The program is divided into tasks that can be executed in parallel. The main thread forks new threads to execute tasks and then joins them back together when they are complete.
- *OpenMP:* It is an API that provides a set of compiler directives, library routines, and environment variables for parallel programming in C, C++, and Fortran. It allows the programmer to specify parallel regions in the code using pragmas, and the compiler generates the necessary code for thread management and synchronization.
- *Grand Central Dispatch (GCD):* It is a technology developed by Apple for macOS and iOS that provides a high-level API for managing concurrent tasks. It uses a dispatch queue to manage the execution of tasks on a pool of threads.
- *Intel Threading Building Blocks (TBB):* It is a C++ template library developed by Intel that provides a high-level abstraction for parallel programming. It allows the programmer to express parallelism using algorithms and data structures, and the library manages thread creation, scheduling, and synchronization.

=== Threading Issues

==== `fork()` and `exec()` System Calls

The `fork()` system calls creates a new process by duplicating the calling process. It returns 0 to the child process and the child's PID to the parent process (-1 on error) and we get two processes, the parent process and the child process.

The `exec()` family of functions replaces the current process image with a new program. It simply transforms the calling process into a different program. It returns -1 on error and after a successful call, the old program code, data and stack are replaced by the new program.

The problem here is, does `fork()` duplicate only the calling thread or all threads in the process? The POSIX standard states that only the calling thread is duplicated in the child process. The child process contains a copy of the parent's address space, but only the calling thread is active. All other threads are not duplicated and do not exist in the child process.

==== Signal Handling

Signals are used to notify a process that a specific event has occurred. They are asynchronous and can be sent by the OS or other processes. When a signal is sent to a process, the OS interrupts the normal flow of execution and invokes a signal handler function to handle the signal.

A signal handler is used to process signals, which occur when a signal generated by a particular event is sent to a process. Each signal is handled by either a default signal handler or a user-defined signal handler. The default action for most signals is to terminate the process, but some signals can be ignored or caught by a user-defined handler.

The problem here is, which thread in a multi-threaded process should handle the signal? There are three possible approaches:
- *Signal is delivered to the thread that generated it:* This approach is simple and intuitive, but it may not be suitable for all types of signals. For example, if a thread generates a signal that indicates an error, it may not be the best thread to handle the error.
- *Signal is delivered to a specific thread:* This approach allows the programmer to specify which thread should handle a specific signal. This can be useful for signals that require special handling, such as signals that indicate a resource limit has been exceeded.
- *Signal is delivered to any thread that is not blocking the signal:* This approach allows the OS to choose which thread should handle the signal based on its current state. This can be useful for signals that can be handled by any thread, such as signals that indicate a timer has expired.

==== Thread Cancellation

It is the process of terminating a thread before it has completed its execution. There are two types of thread cancellation:
- *Asynchronous Cancellation:* The target thread is terminated immediately, regardless of its current state. This can lead to resource leaks and inconsistent states if the thread is in the middle of a critical operation.
- *Deferred Cancellation:* The target thread is notified that it should terminate, but it is allowed to finish its current operation before terminating. This is a safer approach, as it allows the thread to clean up resources and reach a consistent state before terminating. This is the default mode in POSIX threads.
However, invoking cancellation is a request, the actual cancellation depends on the target thread's state and its ability to handle the cancellation request.

==== Thread Local Storage

It is a mechanism that allows each thread to have its own copy of a variable. Unlike global variables (shared across threads), TLS ensures per-thread private data. It is useful for storing data that is specific to a thread, such as error codes, buffers, or state information and avoids the need for synchronization when accessing thread-specific data.

==== Scheduler Activations

It is a mechanism that allows the OS to manage user-level threads while still providing the benefits of kernel-level thread management. It provides a way for the OS to notify the user-level thread library about events that affect thread scheduling, such as blocking system calls or interrupts. The user-level thread library can then take appropriate actions, such as creating new threads, scheduling existing threads, or handling blocking operations. This allows the user-level thread library to have more control over thread scheduling and management, while still allowing the OS to handle low-level events that affect thread execution.

= CPU Scheduling

It is the process by which the operating system decides which process in the ready queue should be allocated the CPU next, whenever the CPU becomes idle. Since the CPU is a limited and highly demanded resource, efficient scheduling is crucial for maximizing system performance. It only applies to the processes in the ready queue (not blocked on I/O). The scheduler chooses a process based on a scheduling algorithm.

These decisions however can only be made when a process:
- *Switches from running to waiting state:* This happens when a process requests I/O or some other event. (Non-Preemptive)
- *Switches from running to ready state:* This happens when a process is interrupted by the OS (timer interrupt). (Preemptive)
- *Switches from waiting to ready state:* This happens when an I/O operation is completed. (Preemptive)
- *Terminates:* This happens when a process completes its execution. (Non-Preemptive)

#grid(
  columns: (1fr, 2fr),
  gutter: 10pt,
  figure(
    image("imgs/CPU-I:O-Burst-Cycle.png"),
    caption: [CPU-I/O Burst Cycle],
  ),
  [
    #definition[CPU-I/O Burst Cycle][
      It is the alternating sequence of CPU bursts and I/O bursts that a process goes through during its execution. A CPU burst is a period of time when a process is executing on the CPU, while an I/O burst is a period of time when a process is waiting for I/O operations to complete.
    ]
    Most processes exhibit this behavior, with short bursts of CPU activity followed by longer periods of I/O wait and alternate between these two states. The final CPU burst is followed by process termination.
  ],
)

#grid(
  columns: (1fr, 2fr),
  gutter: 10pt,
  figure(
    image("imgs/Dispatch-Latency.png"),
    caption: [Dispatcher],
  ),
  [
    #definition[Dispatcher][
      It is the module that gives control of the CPU to the process selected by the short-term scheduler. This involves switching context, switching to user mode and jumping to the proper location in the user program to restart that program.
    ]
    The time it takes for the dispatcher to stop one process and start another is known as the _dispatch latency_.
  ],
)

== Scheduling Criteria

The performance of a scheduling algorithm can be evaluated based on the following criteria: (these are also the goals of scheduling)
- *CPU Utilization:* The percentage of time the CPU is busy. The goal is to keep the CPU as busy as possible (e.g., 40% to 90%).
- *Throughput:* The number of processes completed per unit time. The goal is to maximize throughput (e.g., 10 to 100 processes per second).
- *Turnaround Time:* The total time taken from submission to completion of a process. The goal is to minimize turnaround time. $= "Completion Time" - "Arrival Time"$
- *Waiting Time:* The total time a process spends in the ready queue. The goal is to minimize waiting time. $= "Turnaround Time" - "Burst Time"$
- *Response Time:* The time from submission of a request until the first response is produced. The goal is to minimize response time.
- *Fairness:* Ensuring that all processes get a fair share of the CPU.

== Scheduling Algorithms

#definition[Non-Preemptive/Cooperative Scheduling][
  It is a type of CPU scheduling where a running process is allowed to continue executing until it voluntarily releases the CPU, either by terminating or switching to a waiting state. The operating system does not forcibly interrupt the process, which can lead to longer wait times for other processes.
]
#definition[Preemptive Scheduling][
  It is a type of CPU scheduling where the operating system can interrupt and suspend a currently running process in order to allocate the CPU to another process. This allows for better responsiveness and ensures that high-priority processes can be executed promptly.
]

=== First-Come, First-Served (FCFS) Scheduling

It is the simplest scheduling algorithm that schedules processes in the order they arrive in the ready queue. The process that arrives first is executed first, followed by the next process in the queue and so on. It is a non-preemptive algorithm. The ready queue is treated as a FIFO queue and the scheduler picks the first process in the queue. This shit cannot be used in time-sharing systems.

The main disadvantage of FCFS scheduling is the _convoy effect_, where shorter processes get stuck waiting behind longer processes, leading to poor overall system performance.

=== Shortest Job First (SJF) Scheduling

It is an algorithm where the process with the shortest burst time is selected for execution next. This can lead to improved turnaround time and waiting time for shorter processes. However, it can also result in _starvation_ for longer processes if shorter processes keep arriving. It is non-preemptive.

It can be made preemptive (called Shortest Remaining Time First, SRTF) where the remaining time of the currently running process is compared with the burst time of the newly arrived process. If the new process has a shorter burst time, it preempts the currently running process. Here, the waiting time is $"Total Waiting Time" - "Time executed for" - "Arrival Time"$.

In theory, it can achieve optimal turnaround time and waiting time for all processes, but in practice, it can lead to high overhead due to frequent context switching. It also requires knowledge of the burst time of each process, which is not always available#footnote[Can be estimated using exponential averaging, $t_(n + 1) = alpha t_n + (1 - alpha) t_n$ where $0 < alpha < 1$ but generally $alpha = 0.5$].

=== Priority Scheduling

It is an algorithm where each process is assigned a priority, and the process with the highest priority is selected for execution next. It can be either preemptive or non-preemptive. In preemptive priority scheduling, if a new process arrives with a higher priority than the currently running process, it preempts the current process. In non-preemptive priority scheduling, the current process continues to execute until it completes or voluntarily releases the CPU. It is flexible (models system > kernel thingys). However, it can lead to starvation for lower-priority process which can be mitigated using _aging_ (gradually increasing the priority of waiting processes).

=== Round Robin (RR) Scheduling

It is a preemptive scheduling algorithm designed for time-sharing systems. Each process is assigned a fixed time slice or quantum (e.g., 10-100 milliseconds) during which it can execute. If a process does not complete within its time slice, it is preempted and placed at the end of the ready queue, allowing the next process to execute. This continues in a cyclic manner until all processes are completed. The performance however depends on the size of the time quantum#footnote[Generally taken to be more than the context switching time].

The waiting time for each process can be calculated as:
$
  "Waiting Time" & = "Turnaround Time" - "Burst Time" \
  & = "Last Start Time" - "Arrival Time" - ("Preemption" times "Quantum")
$

=== Multilevel Queue Scheduling

It is an algorithm in which processes are permanently divided into different queues, each queue having its own scheduling algorithm. It is used when processes can be classified into different categories (like foreground and background processes). The ready queue is split into several seperate queues like system processes, interactive processes, batch processes etc.

For processes with priority, each priority level can have its own queue. The scheduling is done first between the queues (based on priority) and then within each queue (based on the queue's scheduling algorithm). This can lead to starvation for lower-priority queues, which can be mitigated using _aging_.


=== Multilevel Feedback Queue Scheduling

#grid(
  columns: 2,
  gutter: 10pt,
  figure(
    image("imgs/Multilevel-Feedback-Queue-Scheduling.png"),
    caption: [Multilevel Feedback Queue Scheduling],
  ),
  [
    It is a more flexible version of multilevel queue scheduling where processes can move between queues based on their behavior and requirements. It allows a process to change its priority level (and hence its queue) based on its CPU burst characteristics. For example, if a process uses too much CPU time, it may be moved to a lower-priority queue. Conversely, if a process waits too long in a lower-priority queue, it may be moved to a higher-priority queue. This dynamic adjustment helps to improve overall system responsiveness and fairness.
  ],
)

The scheduling is done first between the queues (based on priority) and then within each queue (based on the queue's scheduling algorithm). This can lead to starvation for lower-priority queues, which can be mitigated using _aging_.

In general, a multilevel feedback queue scheduler is defined by the following parameters:
- The number of queues
- The scheduling algorithm for each queue
- The method used to determine when to upgrade a process to a higher-priority queue
- The method used to determine when to downgrade a process to a lower-priority queue
- The method used to determine which queue a process will enter when it enters the system

= Process Synchronization

#definition[Race Condition][
  It is a condition where the outcome of a process depends on the sequence or timing of uncontrollable events, such as the order in which threads are scheduled to run. This can lead to unpredictable behavior and bugs that are difficult to reproduce and debug.
]

#problem[Critical Section Problem][
  Given $n$ processes ${P_i}$ that share resources, each process has a section of code called the _critical section_ where it accesses shared resources. The goal is to design a protocol that ensures:
  - *Mutual Exclusion:* No two processes are in their critical sections at the same time
  - *Progress:* If no process is in its critical section and there are processes that wish to enter their critical sections, then only those processes that are not in their remainder sections can participate in the decision of which process will enter its critical section next, and this selection cannot be postponed indefinitely
  - *Bounded Waiting:* There exists a bound on the number of times that other processes are allowed to enter their critical sections after a process has made a request to enter its critical section and before that request is granted. This prevents starvation
]

Here, each process $P_i$ looks like:
```
do {
    // Remainder Section
    // Entry Section
    // Critical Section
    // Exit Section
}
```
#solution[Interrupt-Based Solution][
  Disable interrupts before entering the critical section and enable them after exiting. This ensures that no other process can interrupt the current process while it is in its critical section.

  However, this is a shitty solution because:
  - It works only on uniprocessor systems since on multiprocessor systems, other processors can still run and access shared resources as disabling interrupts only affects the local processor
  - Disabling interrupts for a long time can lead to missed interrupts and system instability. Make the system unresponsive
  - If one process keeps the CPU for a long time, other processes will be starved
]
#solution[Software Solution 1][
  Assume there are only two proceses and `load` and `store` are atomic operations. Take a variable `turn` which indicates whose turn it is to enter the critical section. Each process sets `turn` to the other process's ID before entering its critical section and then waits until `turn` is equal to its own ID. This ensures that only one process can be in its critical section at a time. Initially say `turn = i`.

  #codly(header: [Process $P_i$])
  ```c
  while (true) {
      while (turn == j); // Busy wait
      // Critical Section
      turn = j;         // Give turn to the other process
      // Remainder Section
  }
  ```

  Again, this is a shitty solution because:
  - If only one process wants to enter its critical section, it will still have to wait for the other process to give it the turn, violating the progress condition (the other is in the remainder section and still has a say in the decision). This is called _strict alternation_
  - It relies on busy waiting, wasting CPU cycles
  - There is no bounded waiting guarantee, i.e., one process can be starved if the other process keeps entering its critical section

  This does have mutual exclusion though so decent enough
]
#solution[Peterson's Solution][
  It is a classic big boy software solution for two processes. It uses two shared variables:
  - `flag[i]`: indicates if process `P_i` wants to enter its critical section
  - `turn`: indicates whose turn it is to enter the critical section

  #codly(header: [Process $P_i$])
  ```c
  while (true) {
      flag[i] = true;
      turn = j;
      while (flag[j] && turn == j); // Busy wait
      // Critical Section
      flag[i] = false;
      // Remainder Section
  }
  ```

  This is a good solution because it satisfies all three conditions:
  - Mutual Exclusion: Only one process can be in its critical section at a time
  - Progress: If no process is in its critical section, the process that wants to enter can do so
  - Bounded Waiting: Each process will get a chance to enter its critical section after a finite number of turns

  But, we fucked up with modern computers because of compiler optimizations and CPU instruction reordering. To fix this, we need to use memory barriers or atomic operations to ensure the correct ordering of operations.
]
Consider,
#columns(3)[
  Shared Data,
  ```c
  boolen flag = false;
  int x = 0;
  ```
  #colbreak()
  Process P1,
  ```c
  while (!flag); // Busy wait
  printf("%d", x);
  ```
  #colbreak()
  Process P2,
  ```c
  x = 100;
  flag = true;
  ```
]
The expected output is `100` (looking at the obvious order), however, if the instructions are reordered, `flag = true` may execute before `x = 100`, leading to the output being `0`. Because of this, Peterson's solution may allow both processes to enter their critical sections simultaneously, violating mutual exclusion.

== Memory Barriers

A memory model#footnote[This help programmers to reason about the correctness of concurrent programs] is a set of rules that define how memory operations (reads and writes) on shared memory behave, especially when multiple processors or threads are involved. It specifies:
- *Visibility:* When a write by one processor becomes visible to other processors
- *Ordering:* The order in which memory operations appear to execute

There are two main types of memory models:
- *Strongly Ordered/Sequential Consistency:* This model ensures that memory operations appear to be executed in a strict order, as if they were executed by a single thread. This is the easiest model to reason about but can be inefficient on modern hardware.
- *Weakly Ordered/Relaxed Consistency:* This model allows memory operations to be reordered for performance optimization. This can lead to situations where different processors see memory operations in different orders, making it more difficult to reason about the correctness of concurrent programs.

#definition[Memory Barriers][
  These are special instructions that prevent the compiler and CPU from reordering memory operations across the barrier. They ensure that all memory operations before the barrier are completed before any memory operations after the barrier are started. This is crucial in concurrent programming to maintain data consistency and prevent race conditions.
]
When a memory barrier is encountered, the following rules apply:
- All load and store operations before the barrier must be completed before any load or store operations after the barrier can begin
- The compiler is not allowed to reorder memory operations across the barrier

== Synchronization Hardware

The easiest solution is a _uniprocessor solution_ where we can disable interrupts while in the critical section. This ensures that no other process can interrupt the current process while it is in its critical section. However, this only works on uniprocessor systems and can lead to missed interrupts and system instability and not a scalable solution.

=== Hardware Instructions

These are special hardware instructions that provide atomic operations for synchronization. They are implemented at the CPU level and ensure that certain operations are completed without interruption.

==== Test-and-Set Instruction

It is an atomic instruction that tests the value of a memory location and sets it to a new value in a single, indivisible operation. It is commonly used to implement spinlocks for mutual exclusion.
```c
bool test_and_set(bool *target) {
    bool rv = *target;
    *target = true;
    return rv;
}
```

==== Compare-and-Swap Instruction

It is an atomic instruction that compares the value of a memory location to a given value and, if they are equal, swaps it with a new value. It is commonly used to implement lock-free data structures and algorithms.
```c
int compare_and_swap(int *target, int expected, int new_value) {
    int rv = *target;
    if (rv == expected) *target = new_value;
    return rv;
}
```

These operations are used as building blocks for higher-level synchronization primitives like mutexes, semaphores and monitors.

#codly(header: ["Bounded-Waiting with Compare-and-Swap"])
```c
while (true) {
    waiting[i] = true;
    key = true;
    while (waiting[j] && key) key = compare_and_swap(&lock, false, true);
    waiting[i] = false;
    // Critical Section
    j = (i + 1) % n;
    while (j != i && !waiting[j]) j = (j + 1) % n;
    if (j == i) lock = false;
    else waiting[j] = false;
    // Remainder Section
}
```

=== Atomic Variables

These are special types of variables that support atomic operations, ensuring that operations on them are completed without interruption. They are typically implemented using hardware instructions like test-and-set or compare-and-swap. Atomic variables provide a way to perform thread-safe operations on shared data without the need for locks, reducing the overhead and contention associated with traditional locking mechanisms.

Say we have an atomic integer `atomic_int counter = 0;`, to implement an atomic increment operation, we can use `compare_and_swap` as follows:
```c
void increment(atomic_int *counter) {
    int old_value, new_value;
    do {
        old_value = atomic_load(counter); // Load the current value
        new_value = old_value + 1;        // Calculate the new value
    } while (compare_and_swap(counter, old_value, new_value) != old_value);
}
```

The previous solutions are complicated and inaccessible to application programmers. So we use software tools to solve the critical section problem.

== Software Solutions

=== Mutex Locks

This is the simplest and most common synchronization primitive. It provides mutual exclusion by allowing only one thread to hold the lock at a time. A thread must acquire the lock before entering its critical section and release the lock after exiting. If the lock is already held by another thread, the requesting thread will block until the lock becomes available. The key features of mutex locks are:
- *Mutual Exclusion:* Only one thread can hold the lock at a time, ensuring mutual exclusion
- *Lock Acquisition:* A thread must acquire the lock before entering its critical section
- *Lock Release:* A thread must release the lock after exiting its critical section
- *Ownership:* Only the thread that holds the lock can release it
Most operating systems and threading libraries provide built-in support#footnote[`pthread_mutex` in POSIX] for mutex locks, making them easy to use in multi-threaded applications.

The basic operations are:
- `lock(mutex)`: Acquires the mutex lock. If the lock is already held by another thread, the calling thread will block until the lock becomes available.
- `unlock(mutex)`: Releases the mutex lock. Only the thread that holds the lock can release it.
These are atomic operation implemented using hardware instructions like test-and-set or compare-and-swap.

However, this solution requires busy waiting (thus, this lock is called a spinlock) which wastes CPU cycles. To avoid this, we can use blocking locks where a thread that cannot acquire the lock is put to sleep and is woken up when the lock becomes available.

#codly(header: [Solution using Mutex Locks])
```c
while (true) {
    acquire(mutex);
    // Critical Section
    release(mutex);
    // Remainder Section
}
```

=== Semaphores
#footnote[Introduced by Edsger Dijkstra in 1965]
It is a synchronization primitive used to control access to a shared resource by multiple processes or threads. It is a more general synchronization mechanism than mutex locks and can be used to solve a variety of synchronization problems, including the critical section problem. Basically, it is an integer variable that is accessed through two atomic operations: `wait()` and `signal()`. The key features of semaphores are:
- *Counting Semaphore#footnote[Well technically we can implement this as a binary semaphore]:* It can take non-negative integer values and is used to control access to a resource pool with multiple instances.
- *Binary Semaphore:* It can take only the values 0 and 1 and is used to provide mutual exclusion, similar to a mutex lock.
- *Wait (P) Operation:* Decrements the semaphore value. If the value becomes negative, the calling process is blocked until the semaphore value becomes positive.
- *Signal (V) Operation:* Increments the semaphore value. If there are processes blocked on the semaphore, one of them is unblocked.

#grid(
  columns: 2,
  gutter: 10pt,
  [
    #codly(header: [Wait (P) Operation])
    ```c
    wait(semaphore *S) {
        while (S <= 0); // Busy wait
        S--;
    }
    ```
  ],
  [
    #codly(header: [Signal (V) Operation])
    ```c
    signal(semaphore *S) {
        S++;
    }
    ```
  ],
)

#codly(header: [Memory Barrier using Semaphores])
```c
sem_t synch; // synch = 0

Process P1 {
    S1; // execute S1
    signal(&synch);
}
Process P2 {
    wait(&synch);
    S2; // execute S2
}
```

However, this also requires busy waiting which wastes CPU cycles. To avoid this, we can use blocking semaphores where a process that cannot decrement the semaphore is put to sleep and is woken up when the semaphore value becomes positive. We can implement this using a queue to keep track of the processes that are blocked on the semaphore.

#codly(header: ["Waiting Queue"])
```c
typedef struct {
    int value;
    struct process *queue; // Queue of waiting processes
} semaphore;
```
#grid(
  columns: 2,
  gutter: 10pt,
  [
    #codly(header: [Wait (P) Operation])
    ```c
    wait(semaphore *S) {
        S->value--;
        if (S->value < 0) {
            // Add process to S->queue
            block(); // Block the process
        }
    }
    ```
  ],
  [
    #codly(header: [Signal (V) Operation])
    ```c
    signal(semaphore *S) {
        S->value++;
        if (S->value <= 0) {
            // Remove a process from S->queue
            wakeup(); // Wake up the process
        }
    }
    ```
  ],
)

Since semaphores are pretty low level we can run into some problems like:
- *Deadlock:* This occurs when two or more processes are waiting for each other to release resources, leading to a situation where none of the processes can proceed. For example, if process P1 holds semaphore S1 and is waiting for semaphore S2, while process P2 holds semaphore S2 and is waiting for semaphore S1, both processes will be blocked indefinitely.
- *Priority Inversion:* This occurs when a higher-priority process is waiting for a lower-priority process to release a semaphore, leading to a situation where the higher-priority process is effectively blocked by the lower-priority process. This can lead to suboptimal system performance and responsiveness.
- *Starvation:* This occurs when a process is perpetually denied access to a resource because other higher-priority processes are continuously granted access. This can happen if a process with a lower priority is waiting for a semaphore that is frequently acquired by higher-priority processes.
And most stupid of them all, using the wrong order of `wait()` and `signal()` can lead to incorrect behavior and violations of mutual exclusion.

There are also monitors which are high-level synchronization constructs that provide a way to encapsulate shared data and the operations that manipulate that data. They are designed to simplify the process of writing concurrent programs by providing a higher level of abstraction than semaphores or mutex locks.

=== Monitors

It is an abstract data type that encapsulates shared data and the operations that manipulate that data. Only one process can be active within the monitor at any given time, ensurig mutual exclusion.

#codly(header: [Monitor Implementation using Semaphores])
```c
typedef struct {
    semaphore mutex; // Binary semaphore for mutual exclusion
    semaphore next;  // Semaphore for next process
    int next_count;  // Count of processes waiting on next
} monitor;
// Each procedure in the monitor is implemented as:
void monitor_procedure(monitor *m) {
    wait(&m->mutex);
    // Critical Section
    if (m->next_count > 0) signal(&m->next);
    else signal(&m->mutex);
}
```

==== Condition Variables

These are synchronization primitives used to allow processes to wait for certain conditions to be met. They provide a way for processes to block and wait for a specific condition to become true, and to be notified when that condition changes. These are always used with monitors (or a mutex/lock). It provides two main operations:
- `wait()`: A process that calls `wait()` on a condition variable `x` is suspended until another process signals that the condition has changed.
- `signal()`: A process that calls `signal()` on a condition variable `x` wakes up one of the processes waiting on `x`, if any.

#codly(header: [Monitor Implementation using Condition Variables])
```c
typedef struct {
    condition_variable cond; // Condition variable for blocking/waking up processes
    int value;               // Value being monitored
} monitor;
```
If several processes are waiting on the same condition variable, we can use the conditional-wait construct `x.wait(c)` where `c` is an integer (priority number) where the process with the highest priority is woken up first.

== Liveness

#definition[Liveness][
  It is a property of concurrent systems that ensures that certain actions or events will eventually occur. In the context of process synchronization, liveness guarantees that processes will not be indefinitely delayed or blocked from making progress.
]

=== Deadlock

This is caused by the following four conditions:
- *Mutual Exclusion:* At least one resource must be held in a non-sharable mode, i.e., only one process can use the resource at any given time.
- *Hold and Wait:* A process must be holding at least one resource and waiting to acquire additional resources that are currently being held by other processes.
- *No Preemption:* Resources cannot be forcibly taken away from a process holding them; they must be released voluntarily by the process.
- *Circular Wait:* There must be a circular chain of two or more processes, each of which is waiting for a resource held by the next process in the chain.

Consider the following example with two processes and two resources:
#grid(
  columns: 2,
  gutter: 10pt,
  [
    #codly(header: [Process P1])
    ```c
    wait(S); // Acquire resource R1
    wait(Q); // Wait for resource R2
    // Critical Section
    signal(Q); // Release resource R2
    signal(S); // Release resource R1
    ```
  ],
  [
    #codly(header: [Process P2])
    ```c
    wait(Q); // Acquire resource R2
    wait(S); // Wait for resource R1
    // Critical Section
    signal(S); // Release resource R1
    signal(Q); // Release resource R2
    ```
  ],
)
Here, if process P1 acquires resource R1 and process P2 acquires resource R2, both processes will be waiting for each other to release the resources they need, leading to a deadlock.

=== Starvation

It is a situation where a process is perpetually denied access to a resource because other higher-priority processes are continuously granted access. This can happen if a process with a lower priority is waiting for a semaphore that is frequently acquired by higher-priority processes.

=== Priority Inversion

It occurs when a higher-priority process is waiting for a lower-priority process to release a semaphore, leading to a situation where the higher-priority process is effectively blocked by the lower-priority process. This can lead to suboptimal system performance and responsiveness. This can be solved using _priority inheritance_ where the lower-priority process temporarily inherits the higher priority of the waiting process until it releases the semaphore.

= Deadlocks

A system consists of different resource types $R_1$, $R_2$, ..., $R_m$ where each resource type $R_i$ has $W_i$ instances. A process can request and release resources of different types. Each process utilises a resource in the order, _request_ $->$ _use_ $->$ _release_.

== Resource Allocation Graph

Consider a set of vertices $V$ and edges $E$, where $V = T union R$, where $T = {T_i | i <= n}$ represents all the threads in the system and $R = {R_i | i <= m}$ represents all the resource types in the system (a resource can either be single instance or multiple instance.). A request edge is defined as $T_i -> R_j$ and an assignment edge is defined as $R_j -> T_i$. A request edge indicates that thread $T_i$ has requested an instance of resource type $R_j$ and is waiting for it. An assignment edge indicates that an instance of resource type $R_j$ has been allocated to thread $T_i$.

Now, if the graph contains no cycles, then no thread in the system is deadlocked. If the graph contains a cycle and each resource type has only one instance, then a deadlock exists. If the graph contains a cycle and at least one resource type has multiple instances, then a deadlock may exist.

#grid(
  columns: (1fr, 2fr),
  gutter: 10pt,
  figure(
    image("imgs/Resource-Allocation.png"),
    caption: [Resource Allocation Graph],
  ),
  [
    We have:
    - One instance of $R_1$
    - One instance of $R_3$
    - Two instance of $R_2$
    - Four instance of $R_4$
    - $T_1$ holds one instance of $R_1$ and waits for one instance of $R_2$
    - $T_2$ holds one instance of $R_1$, one instance of $R_2$ and waits for one instance of $R_3$
    - $T_3$ holds one instance of $R_3$
  ],
)

#example[Deadlock Detection][
  #grid(
    columns: (1fr, 2fr),
    gutter: 10pt,
    figure(
      image("imgs/Resource-Allocation-EX-1.png"),
    ),
    [
      Check if the following system is in a deadlock state.
    ],
  )
]
#solution[
  We solve these questions using the following table and writing the processes that can get completed one after the other:
  #table(
    columns: 7,
    align: center,
    table.header(
      [],
      table.cell(colspan: 2)[Allocations],
      table.cell(colspan: 2)[Request],
      table.cell(colspan: 2)[Available],
    ),
    [], [$R_1$], [$R_2$], [$R_1$], [$R_2$], [$R_1$], [$R_2$],
    $P_1$, [0], [1], [1], [0], [0], [0],
    $P_2$, [1], [0], [0], [0], [1], [0],
    $P_3$, [1], [0], [0], [1], [1], [1],
  )
  Thus, the correct order will be $P_2 -> P_1 -> P_3$.
]

== Handling Deadlocks

We can either prevent or avoid deadlocks. Prevention is easier to implement but is not as efficient as avoidance.

=== Deadlock Prevention

We just need to invalidate one of the four necessary conditions for deadlock:
- *Mutual Exclusion:* Trivial for shareable resources. We just need to ensure this for non-sharable resources.
- *Hold and Wait:* We can ensure that a process can only request resources when it is not holding any resources. This can be done by requiring a process to release all its resources before requesting new ones or by requiring a process to request all the resources it will need at once.
- *No Preemption:* If a process is holding some resources and requests another resource that cannot be immediately allocated to it, then all resources currently being held are released. The process will be restarted only when it can regain its old resources as well as the new ones that it is requesting.
- *Circular Wait:* We can impose a total ordering of all resource types and require that each process can only request resources in an increasing order of enumeration.

Invalidating the circular wait condition is the most common. Say that we have two mutexes `M1 = 1` and `M2 = 5`, if a thread already holds `M2`, it cannot request `M1` since `5 > 1`.

=== Deadlock Avoidance

This requires that the system has some additional a priori information about how resources are to be requested.

The simplest (also the most useful) model requires each thread to declare the maximum number of resources of each type that it _may_ need. Then, the deadlock-avoidance-algorithm dynamically examines the resource-allocation state#footnote[It is defined by the number of available and allocated resources and the maximum demands of the process] to ensure that there can never be a circular-wait condition.

#grid(
  columns: (2fr, 3fr),
  gutter: 10pt,
  figure(
    image("imgs/Safe-Unsafe-Deadlock.png"),
  ),
  definition[Safe State][
    A system is in a safe state, if $space exists <T_1, T_2, dots.h, T_n>$ of all threads such that $forall T_i$ the resources that $T_i$ can still request can be satisfied by the currently available resources and the resources held by all $T_j$, where $j < i$.
    - If $T_i$ is not immediately satisfied, then it can wait until all $T_j$ have finished and released their resources
    - When $T_j$ is finished, $T_i$ can obtain all the resources it needs, execute, and return its allocated resources to the system
    - When $T_i$ terminates, $T_(i + 1)$ can obtain its needed resources, and so on
  ],
)

==== Resource Allocation Graph Algorithm

Here, we define a new type of edge called a *Claim Edge* ($P_i arrow.r.dotted R_j$). It denotes that a process _may_ request some resource.
- It converts to a request edge when a thread makes a request for a resource
- It converts to an assignment edge when the resource is allocated
- When the resource is released, it converts back to a claim edge

The request can only be granted if converting the request edge to an assignment edge does not result in a cycle in the resource-allocation graph.

This only works for single instance resources.

==== Banker's Algorithm

This is much better than the previous one since it works for multiple instance resources as well. It is named so because it is analogous to a banker who lends money to customers, ensuring that the bank never allocates its available cash in such a way that it cannot satisfy the needs of all its customers.

Let $n$ be the number of processes and $m$ be the number of resource types. We define the following data structures:
- *Available*: It is a vector of length $m$ that indicates the number of available resources of each type. $"available"[j] = k$ implies k instances of resource $j$.
- *Max*: It is an $n times m$ matrix that defines the maximum demand of each process. $"max"[i][j] = k$ implies that process $i$ may request at most $k$ instances of resource type $j$.
- *Allocation*: It is an $n times m$ matrix that defines the number of resources of each type currently allocated to each process. $"allocation"[i][j] = k$ implies that process $i$ is currently allocated $k$ instances of resource type $j$.
- *Need*: It is an $n times m$ matrix that indicates the remaining resource needs of each process. It is defined as $"need"[i][j] = "max"[i][j] - "allocation"[i][j]$.

#example[
  Given the following data structures, find if the system is in a safe state:
  $
    "Allocation" & = mat(
                     0, 0, 1, 2;
                     1, 0, 0, 0;
                     1, 3, 5, 4;
                     0, 6, 3, 2;
                     0, 0, 1, 4
                   ) \
           "Max" & = mat(
                     0, 0, 1, 2;
                     1, 7, 5, 0;
                     2, 3, 5, 6;
                     0, 6, 5, 2;
                     0, 6, 5, 6
                   ) \
     "Available" & = [1, 5, 2, 0]
  $
]
#solution[
  Need to fix this
  #table(
    columns: 4 * 4 + 1,
    align: center,
    table.header(
      [],
      table.cell(colspan: 4)[*Allocation*],
      table.cell(colspan: 4)[*Max*],
      table.cell(colspan: 4)[*Available*],
      table.cell(colspan: 4)[*Need*],
    ),
    [],
    [A],
    [B],
    [C],
    [D],
    [A],
    [B],
    [C],
    [D],
    [A],
    [B],
    [C],
    [D],
    [A],
    [B],
    [C],
    [D],

    $P_0$,
    [0],
    [0],
    [1],
    [2],
    [0],
    [0],
    [1],
    [2],
    [1],
    [5],
    [2],
    [0],
    [0],
    [0],
    [0],
    [0],

    $P_1$,
    [1],
    [0],
    [0],
    [0],
    [1],
    [7],
    [5],
    [0],
    [1],
    [5],
    [2],
    [0],
    [0],
    [7],
    [5],
    [0],

    $P_2$,
    [1],
    [3],
    [5],
    [4],
    [2],
    [3],
    [5],
    [6],
    [1],
    [5],
    [2],
    [0],
    [1],
    [0],
    [0],
    [2],

    $P_3$,
    [0],
    [6],
    [3],
    [2],
    [0],
    [6],
    [5],
    [2],
    [1],
    [5],
    [2],
    [0],
    [0],
    [0],
    [2],
    [0],

    $P_4$,
    [0],
    [0],
    [1],
    [4],
    [0],
    [6],
    [5],
    [6],
    [1],
    [5],
    [2],
    [0],
    [0],
    [6],
    [4],
    [2],
  )
  Thus, we can see that the safe sequence is $P_0 -> P_2 -> P_3 -> P_4 -> P_1$.
]

The safe state algorithm works as follows:
+ Let Work and Finish be vectors of length m and n respectively. Initialize Work = Available and Finish[i] = false for all i.
+ Find an index i such that both: (go to step 3 if no such i exists)
  - Finish[i] == false
  - Need[i] <= Work
+ Work = Work + Allocation[i]; Finish[i] = true; go to step 2.
+ If Finish[i] == true for all i, then the system is in a safe state.

=== Deadlock Detection Algorithm

It is a method used by the OS to determine if a deadlock has occurred in the system. It is typically used in systems where deadlock prevention or avoidance is not implemented.

==== Single Instance of Each Resource Type

Here, we construct a wait-for graph from the resource-allocation graph by removing the resource nodes and collapsing the edges. A cycle in the wait-for graph indicates a deadlock.

The wait-for graph is maintained where the nodes represent processes and a directed edge from process $P_i$ to process $P_j$ indicates that process $P_i$ is waiting for a resource held by process $P_j$. Periodically, the OS invokes a deadlock detection algorithm that searches for cycles in the wait-for graph.

But, this is kinda time consuming since we need to search for cycles in a graph which takes $O(n^2)$ time, thus, it is invoked infrequently.

==== Multiple Instances of Each Resource Type

Here, we use a similar approach to the banker's algorithm. We maintain the following data structures:
- *Available*: It is a vector of length $m$ that indicates the number of available resources of each type. $"available"[j] = k$ implies k instances of resource $j$.
- *Allocation*: It is an $n times m$ matrix that defines the number of resources of each type currently allocated to each process. $"allocation"[i][j] = k$ implies that process $i$ is currently allocated $k$ instances of resource type $j$.
- *Request*: It is an $n times m$ matrix that indicates the current request of each process. $"request"[i][j] = k$ implies that process $i$ is currently requesting $k$ more instances of resource type $j$.

The deadlock detection algorithm works as follows:
+ Let Work and Finish be vectors of length m and n respectively. Initialize Work = Available and Finish[i] = false for all i.
+ Find an index i such that both: (go to step 3 if no such i exists)
  - Finish[i] == false
  - Request[i] <= Work
+ Work = Work + Allocation[i]; Finish[i] = true; go to step 2.
+ If Finish[i] == false for some i, then process $P_i$ is deadlocked.
The time complexity of this algorithm is $O(m n^2)$ since each process may need to be examined multiple times.

=== Deadlock Recovery

==== Process Termination/Pessimistic Approach

This involves terminating one or more processes involved in the deadlock until the deadlock is resolved. There are two approaches:
- *Terminate all deadlocked processes:* This is the simplest approach but can lead to significant loss of work and data.
- *Terminate processes one at a time:* This approach involves terminating one process at a time and checking if the deadlock is resolved. This continues until the deadlock is resolved. The process to be terminated can be selected based on various criteria such as priority, CPU time used, resources held, etc.

==== Resource Preemption/Optimistic Approach

This involves temporarily taking resources away from one or more processes involved in the deadlock and allocating them to other processes until the deadlock is resolved. The key steps are:
- *Select a victim process:* This involves selecting a process to preempt resources from. The selection can be based on various criteria such as priority, CPU time used, resources held, etc.
- *Preempt resources:* This involves taking resources away from the selected process and allocating them to other processes that are waiting for those resources.
- *Rollback the victim process:* This involves rolling back the victim process to a safe state before it acquired the preempted resources. This may involve saving the state of the process before preemption and restoring it later.
- *Restart the victim process:* This involves restarting the victim process after it has been rolled back to a safe state.

So, the thing is that deadlocks realistically don't occur that often in practice, so most systems just ignore them and let the processes hang like Linux#footnote[Fact check me on this] does.

= Memory Management

It involves organising and controlling computer memory, allocating space to processes, and managing the movement of data between main memory and storage. It makes sure that processes#footnote[which must be loaded from the disk into memory for execution] can only access its assigned memory locations, provides protection between processes, and optimises memory usage to improve system performance.

== Protection

The authorised memory region of a program is defined by the base register and the limit register. The $("base", "limit")$ register pairs define the logical address space of a process.

#grid(
  columns: (1fr, 2fr),
  gutter: 10pt,
  figure(
    image("imgs/Hardware-Address-Protection.png"),
    caption: [Hardware Address Protection],
  ),
  [
    When a process generates a logical address, the base register is added to the logical address to produce the physical address. The limit register is used to check if the logical address is within the authorised memory region of the process. If the logical address is greater than or equal to the limit register, a memory protection violation occurs, and the process is terminated.
  ],
)
The actual instructions to load the base and limit registers are privileged instructions#footnote[accessible only by the OS kernel].

== Address Binding

#grid(
  columns: (1fr, 2.5fr),
  gutter: 10pt,
  figure(
    image("imgs/Address-Binding.png"),
  ),
  [
    It is the process of mapping logical addresses generated by a program to physical addresses in main memory. There are three main stages of address binding:
    - *Compile Time Binding:* If the memory location where the process will reside is known at compile time, then the compiler can generate absolute code. The disadvantage is that the process cannot be moved in memory during execution.
    - *Load Time Binding:* If the memory location is not known at compile time, then the compiler generates relocatable code. The final binding is delayed until load time when the process is loaded into memory. The disadvantage is that the process cannot be moved in memory during execution.
    - *Execution Time Binding:* If the process can be moved during its execution from one memory segment to another, then binding must be delayed until run time. This requires hardware support for address mapping, typically through the use of a memory management unit (MMU)#footnote[More later].
  ],
)

== Virtual Memory

It is a concept that allows programs to use more memory than is physically available in the system. It creates an illusion for users of a very large (main) memory.

This is done by mapping logical/virtual addresses to physical addresses by the OS. These are the exact same in compile-time and load-time execution time address binding schemes, but differ in execution-time binding scheme.

== Memory Management Unit (MMU)

#grid(
  columns: (1fr, 2fr),
  gutter: 10pt,
  figure(
    image("imgs/MMU.png"),
  ),
  [
    It is a hardware device that maps virtual addresses to physical addresses at run time. It is typically implemented as a part of the CPU and works in conjunction with the operating system to provide memory protection and address translation.
  ],
)

A very simple address mapping scheme is to use a single base register#footnote[This is generally called the relocation register, obviously] that holds the starting physical address of the process in memory. The virtual address generated by the process is added to the base register to produce the physical address.
$
  "Physical Address" = "Base Register" + "Virtual Address"
$


== Dynamic Loading and Linking

#definition[Dynamic Loading][
  It is a technique where a program is loaded into memory only when it is needed during execution, rather than loading the entire program at once. This allows for more efficient use of memory and can reduce the initial load time of a program.
]
The OS loads the routine#footnote[Kept in a reloacatable load format on disk] from disk into memory when it is called for the first time.

It is technically not an OS thing and more of a program design, but the OS can provide support for it.

#definition[Dynamic Linking][
  It is a technique where a program is linked to shared libraries at runtime rather than at compile time. This allows for more efficient use of memory and can reduce the size of the executable file.
]
When a program calls a function in a dynamic library, a stub#footnote[Small piece of code] is used. If the routine is loaded, the stub replaces itself with the address of the routine and jumps to it. If the routine is not loaded, the stub requests the OS to load the routine into memory, updates itself with the address of the routine, and then jumps to it.

It is particularly useful for system libraries#footnote[Called shared libraries or dynamic link libraries (DLLs)] that are used by multiple programs.

== Contiguous Memory Allocation

It is the simplest memory allocation scheme where each process is allocated a single contiguous block of memory.

The main memory is divided into two partitions:
- *Resident OS:* This contains the OS code and is usually located at the lower end of memory.
- *User Processes:* This contains the user processes and is usually located at the higher end of memory.
Free memory is managed using a free list#footnote[Linked list of all free memory blocks] or a bitmap#footnote[Each bit represents a block of memory, 0 for free and 1 for allocated].

However, this leads to external fragmentation#footnote[More later], which can be solved using compaction#footnote[Shifting all processes to one end of memory to create a large block of free memory].

So, clearly this is a shit solution in terms of scalability since it requires memory to be shuffled around which causes latency and also updating the free list is too much.

== Variable Partition

It is another simple memory allocation scheme used by old operating systems.

It divides the memory into partitions of variable size that are sized to the requirements of each incoming process (rather than being fixed sized). When a new process arrives a free block of memory, called a hole (which is large enough) is found and allocated to the process. After termination, adjacent free blocks are merged together. This dynamic reallocation aims to minimize wasted memory.

There are multiple algorithms that can be used to request an arbitrary sized hole from a list of free holes:
- *First-Fit*: Allocate the first hole large enough for the request
- *Best-Fit*: Allocate the smallest hole that is still big enough
- *Worst-Fit*: Allocate the largest available hole

== Fragmentation

It is the phenomenon where memory is wasted due to inefficient allocation and deallocation of memory blocks. There are two types of fragmentation:
- *External Fragmentation:* It occurs when free memory is divided into small, non-contiguous blocks that are too small to satisfy the memory requests of incoming processes. This can lead to a situation where there is enough total free memory to satisfy a request, but it is not contiguous, leading to wasted memory.
- *Internal Fragmentation:* It occurs when a process is allocated a block of memory that is larger than its actual memory requirements. The unused portion of the allocated block is wasted, leading to inefficient memory usage.

First-Fit analysis reveals that, given a series of random-sized memory requests, approximately 50% of memory may be wasted due to external fragmentation. Best-Fit and Worst-Fit do not perform significantly better.

We can reduce external fragmentation using compaction which was mentioned earlier but it only works if the relocation is dynamic (i.e., execution-time binding is used).

== Paging

It is a memory management scheme that eliminates the need for contiguous allocation of physical memory. It divides the logical address space of a process into fixed-size blocks called pages and the physical memory into fixed-size blocks called frames#footnote[The size is a power of 2 $in [512 "bytes", 16 "Mbytes"]$]. The size of a page is equal to the size of a frame.

When a process is loaded into memory, its pages are mapped to available frames in physical memory. The mapping is maintained in a data structure called the page table, which is used by the MMU to translate virtual addresses to physical addresses.

#grid(
  columns: (1fr, 2fr),
  gutter: 10pt,
  figure(
    image("imgs/Paging-Hardware.png"),
    caption: [Paging Hardware],
  ),
  [
    The address generated by the CPU is divided into two parts:
    - *Page Number ($p$)*: It is used as an index into the page table to find the corresponding frame number.
    - *Page Offset ($d$)*: It is the offset within the page/frame.
  ],
)
Thus, the physical address is obtained by concatenating the frame number with the page offset. The formulas are:
$
                   p & = "logical address" / "page size" \
                   d & = "logical address" % "page size" \
  "physical address" & = "frame number" * "page size" + d
$

However, this leads to internal fragmentation since the last page of a process may not be completely filled. The obvious solution to use smaller page sizes#footnote[Solaris supports $8 "KB"$ and $4 "MB"$ page sizes] sucks since it increases the size of the page table and the overhead of managing it.

=== Page Table Implementation

A page table in memory is referenced using:
- *Page-Table Base Register (PTBR)*: It holds the physical address of the page table.
- *Page-Table Length Register (PTLR)*: It indicates the number of pages in the page table.

Here, every data access required two memory accesses, one for the page table and one for the data. This can be solved using a special cache called the Translation Lookaside Buffer (TLB)#footnote[These are also called associative memory].

#definition[Translation Lookaside Buffer (TLB)][
  It is a fast small#footnote[Typically contains 64 to 1024 entries] associative cache used by the MMU to speed up translation of virtual addresses to physical addresses. Each entry uniquely identifies each process to provide address-space protection for that processes by storing a $("Page Number", "Frame Number")$ pair.
]

#grid(
  columns: (2fr, 1.5fr),
  gutter: 10pt,
  figure(
    image("imgs/Paging-Harware-TLB.png"),
    caption: [Paging Hardware with TLB],
  ),
  [
    The *Hit-Ratio* is the percentage of memory references found in the TLB. Realistically speaking, it is around $80 percent$ to $98 percent$.
  ],
)
If the TLB hit ratio is $alpha$, then the effective memory access time (EAT) is given by:
$
  "EAT" & = alpha * "TLb access time" + (1 - alpha) * 2 * "memory access time"
$

However, just storing a pair is not enough to gurantee memory protection. Thus, a _valid-invalid_ bit is associated with each entry in the page table. If the bit is set to _valid_, the associated page is in the process's logical address space, and if it is set to _invalid_, the page is not in the process's logical address space. Any violation results in a trap to the OS.

=== Shared Pages

Pages can be shared among processes to allow for efficient use of memory and inter-process communication. Shared pages can be used for:
- *Shared Libraries:* Multiple processes can share the same code pages of a shared library, reducing memory usage.
- *Inter-Process Communication:* Processes can share data pages to communicate with each other.

Each process also keeps a separate copy of the code and data pages that it is using privately which can appear anywhere in the logical address space of the process.

=== Page Table Structure

Using straight forward page tables can lead to large memory overhead since each process requires its own page table. For example, with a page size of $4 "KB"$ and a logical address space of $2^32 "bytes"$, each page table would require $2^20$ entries (4 MB per process) which is obviously too much.

Thus one solution is to divide the page table into smaller units which we will discuss now.

==== Hierarchical Paging

#grid(
  columns: (2fr, 3fr),
  gutter: 10pt,
  figure(
    image("imgs/Hierarchical-Page-Tables.png"),
  ),
  [
    It is a multi-level page table scheme where the page table is divided into multiple levels. The first level page table contains pointers to second level page tables, which in turn contain pointers to third level page tables, and so on. The last level page table contains the actual frame numbers.
  ],
)

For the same example, a logical address is divided into a page number (20 bits) and a page offset (12 bits). Now, to page the page table, it is further divided into a 10-bit first-level page number and a 10-bit second-level page number. Thus, the logical address is divided into three parts: a 10-bit first-level page number, a 10-bit second-level page number, and a 12-bit page offset.
#figure(
  image("imgs/Two-Level-Page-Table.png"),
)
$
  "logical address" & = "first-level page number" + "second-level page number" + "page offset"
$
The physical address is obtained by concatenating the frame number from the second-level page table with the page offset.

==== Hashed Page Tables

#grid(
  columns: (2fr, 3fr),
  gutter: 10pt,
  figure(
    image("imgs/Hashed-Page-Tables.png"),
  ),
  [
    This is more common in $> 32$ bit systems. Here, the virtual page number is hashed into a page table which contains a linked list of page table entries that hash to the same location. Each entry contains the virtual page number, the corresponding frame number, and a pointer to the next entry in the list.
  ],
)

Virtual addresses are translated by hashing the virtual page number to find the appropriate page table entry in the hash table. The linked list is then traversed to find the matching virtual page number, and the corresponding frame number is used to compute the physical address.

For $64 "bit"$ systems, *clustered page tables* are used, which are similar to these, where each entry in the page table refers to a block of pages rather than a single page. This reduces the size of the page table and the number of memory accesses required for address translation. These are especially useful for sparse address spaces.

==== Inverted Page Tables

#grid(
  columns: (2fr, 3fr),
  gutter: 10pt,
  figure(
    image("imgs/Inverted-Page-Tables.png"),
  ),
  [
    Here, there is a single page table for the entire system that contains one entry for each frame of physical memory. Each entry contains the virtual address of the page stored in that frame, along with information about the process that owns the page.
  ],
)
To translate a virtual address, the inverted page table is searched for an entry that matches the virtual page number and the process ID. If a match is found, the corresponding frame number is used to compute the physical address. If no match is found, a page fault occurs.

This reduces the amount of memory required for page tables, especially in systems with large amounts of physical memory. However, it can lead to increased overhead for address translation due to the need to search the inverted page table but can be reduced using hashing techniques or using a TLB.

== Swapping

It is a memory management technique where a process is temporarily moved from main memory to secondary storage (usually a hard disk) to free up memory for other processes. When the process is needed again, it is swapped back into main memory. This allows a process to be larger than the available physical memory but incurs overhead and complexity.

The major part of the swap time is the transfer time for moving the process between main memory and secondary storage and the total transfer time is proportional to the size of the process.

The decision to swap a process is made by OS on the basis of a ready queue and memory allocation policies.

=== Backing Store
#grid(
  columns: (2fr, 3fr),
  gutter: 10pt,
  figure(
    image("imgs/Swapping.png"),
  ),
  [
    It is a fast large enough disk storage to accommodate copies of all memory images for all users. It is used to store the swapped-out processes. It is typically implemented as a dedicated partition on the hard disk or a separate disk altogether to improve performance. It allows direct access to the swapped-out processes without interfering with the normal file system operations.
  ],
)

=== Roll Out, Roll In

It is a swapping technique where processes can be swapped out of main memory even if they are not blocked or waiting for I/O operations. This allows the OS to free up memory for other processes that may need it more urgently. When a rolled-out process is needed again, it is rolled back into main memory. This technique is particularly useful in systems with limited memory resources or when running large applications that require more memory than is available in main memory. However, it can lead to increased overhead and complexity in managing the swapped-out processes.

Realistically, swapping is not used in modern systems since virtual memory techniques provide better performance and flexibility but still may be enabled by the OS when running low-memory situations.

= Virtual Memory

Virtual Memory is an abstraction separating a program's logical view of the memory from the actual physical memory. Since all of the program doesn't need to be in memory at the same time, the OS gives the illusion of a very large, continuous (main) memory and thus, the programs are not constrained by actual memory size, allowing more processes to be run concurrently.

The virtual address space usually starts at address 0 and is continuous up to a maximum address determined by the number of bits used for addressing. The physical memory, on the other hand, may be fragmented and non-contiguous. It is generally implemented using _demand paging_ or _demand segmentation_.

The stack grows downwards from high memory addresses, while the heap grows upwards from low memory addresses. This allows for efficient use of memory and helps prevent fragmentation. This has the following benefits:
- Maximises address space use
- No physical memmory is needed until the heap or stack grows to a given new page
- Enables sparse memory spaces with holes (gap between the stack and heap) left for growth, dynamically linked libraries, etc

== Demand Paging

It is a memory management technique where pages are loaded into memory only when they are needed, rather than loading the entire process into memory at once. This allows for more efficient use of memory and can reduce the initial load time of a process.#footnote[The reason this shit works well is called locality of reference which is some COA stuff]

When a process tries to access a page that is not currently in memory, a page fault occurs, and the OS must bring the required page from secondary storage into main memory. The OS uses a page replacement algorithm to determine which page to evict from memory if there is no free frame available.

There is also a *lazy swapper* or *pager* that brings a page into memory only when it is needed, rather than preloading pages in anticipation of future requests. This reduces the amount of memory required for a process and can improve system performance.

We use the valid-invalid bit to see whether a page is currently loaded in a frame or not currently in the memory (or not even mapped by the process). If a reference to an invalid page occurs, the MMU generates a page fault.

=== Handling a Page Fault

#grid(
  columns: (2fr, 1fr),
  gutter: 10pt,
  figure(
    image("imgs/Handling-Page-Fault.png"),
  ),
  [
    Too many page faults is very bad, leading to *thrashing* where the system spends more time handling page faults than executing processes.
  ],
)

+ *Trap to OS*: The MMU detects a page table entry marked invalid and triggers a trap (interrupt) to the operating system
+ *Save State*: The OS saves user registers and process context
+ *Check Reference*: The OS checks whether the page reference is valid (belongs to the process's address space). If not, it terminates the process
+ *Locate on Disk*: If valid but not resident, the OS locates the required page on disk
+ *Find Free Frame*: Search for a free frame in memory. If none is available, use a page replacement algorithm to select a victim frame (and write to disk if necessary)
+ *Swap Page*:  Read the needed page from disk into the chosen frame (using scheduled I/O operations)
+ *Update Table*:  Set page table and frame table entries to indicate that the page is now in memory (set the valid bit)
+ *Restart Instruction*: Resume the instruction that caused the page fault, now that the data/code is present

Most OS maintain a _free-frame list_ containing all available frames. When a page needs to be loaded, a frame is taken from this list. If the list is empty, a page replacement algorithm is used to select a victim frame. The free frames are allocated using *zero-fill-on demand* where the content of the frame is filled with zeros when allocated to a process.

The time taken to service a page fault is significantly higher than a normal memory access due to the need to access secondary storage. The effective access time (EAT) can be calculated as:
$
  "EAT" = (1 - p) * "memory access time" + p * ("page fault service time" + "swap page in" + "swap page out")
$

Realistically, even with $p = 1/1000$, the slow down is by a factor of 40, so $p = 1/400000$ is required for a lesser 10% slowdown!

== Copy on Write (CoW)

It is an optimization technique used in memory management where multiple processes can share the same physical memory pages until one of them attempts to modify the page. When a process tries to write to a shared page, a copy of the page is created for that process, allowing it to modify its own copy without affecting the other processes.

This technique is particularly useful in scenarios where processes create copies of data structures, such as during process forking. Instead of duplicating the entire memory space of the parent process, the child process can share the same pages until it needs to modify them. (`vfork()` in Unix systems uses this technique)

== Page Replacement

When a page fault occurs and there are no free frames available, the OS must select a victim page to evict from memory. The choice of which page to replace can significantly impact system performance.

This completes the separation of logical memory from physical memory, allowing the OS to use physical memory more efficiently.

The modify/dirty bit is used to track whether a page has been modified since it was loaded into memory. If the dirty bit is set, the page must be written back to disk before being evicted; otherwise, it can be discarded.

#figure(
  image("imgs/Page-Replacement.png", width: 300pt),
)

Page replacement basically works as:
+ Find the location of the desired page on disk
+ Find a free frame:
  - If there is a free frame, use it
  - If there is no free frame, use a page replacement algorithm to select a victim frame
+ If the victim frame is dirty, write it back to disk
+ Read the desired page into the selected frame
+ Update the page table and frame table to reflect the changes
+ Continue the process (restart the instruction that caused the page fault)

Clearly, this may cause two page faults in succession if the victim page is dirty, thus increasing the EAT.

=== Page Replacement Algorithms

The goal of page replacement algorithms is to minimize the number of page faults. We use a reference string to represent the sequence of page references made by a process. For example, the reference string $7,0,1,2,0,3,0,4,2,3,0,3,0,3,2,1,2,0,1,7,0,1$ represents a sequence of page references made by a process. The better an algorithm is at minimizing page faults, the better it is.

==== First-In First-Out (FIFO)

#figure(
  image("imgs/FIFO-Page-Replacement.png"),
  caption: [FIFO Page Replacement Example],
)

It is the simplest page replacement algorithm where the oldest page in memory is replaced when a new page needs to be loaded. It uses a queue to keep track of the order in which pages were loaded into memory.

Also, obviously increasing the number of frames should reduce the number of page faults? Not really, as shown by Belady's Anomaly where increasing the number of frames can actually increase the number of page faults for some reference strings and non-stack algorithms like this one.

==== Optimal Page Replacement

#figure(
  image("imgs/Optimal-Page-Replacement.png"),
  caption: [Optimal Page Replacement Example],
)

It is a theoretical page replacement algorithm that replaces the page that will not be used for the longest period of time in the future. It is optimal in the sense that it minimizes the number of page faults for a given reference string. However, it is not implementable in practice since it requires knowledge of the future.

It is mainly used as a benchmark to compare the performance of other page replacement algorithms.

==== Least Recently Used (LRU)

#figure(
  image("imgs/LRU-Page-Replacement.png"),
  caption: [LRU Page Replacement Example],
)

It is a practical page replacement algorithm that replaces the page that has not been used for the longest period of time. It uses a stack or a counter to keep track of the order in which pages were accessed. When a page is accessed, it is moved to the top of the stack or its counter is updated. When a page needs to be replaced, the page at the bottom of the stack or with the lowest counter value is selected for replacement.

Rather than using the future like Optimal, it uses the past to make decisions. It is more effective than FIFO and does not suffer from Belady's Anomaly.

=== Page Buffering Algorithm

It is an OS technique that is used to improve the performance of page replacement algorithms. When a page is replaced, instead of immediately writing it back to disk, it is placed in a buffer called the free list. If the page is needed again before it is written back to disk, it can be quickly retrieved from the buffer, reducing the number of disk accesses.

It helps with:
- *Fast Reuse of Freed Frames*: The evicted page is kept in a buffer, allowing for quick retrieval if it is needed again soon
- *Handling Modified Pages*: If the page being evicted is dirty, instead of writing immediately (which is slow), it is placed in a modified page list to be written back later, allowing the system to continue processing other pages in the meantime.
- *Quickly Undoing Wrong Replacements*: Sometimes, we have some regrets, like the replacement regret where a replaced page is needed again soon after eviction. If the page is still in the buffer, the OS can quickly restore it without needing to read from disk again.

=== Allocation of Frames

==== Fixed Allocation

Here, the naive approach is to allocate equal number of frames to each process. However, this may not be optimal since different processes may have different memory requirements.

Thus, we have proportional allocation, where each process is allocated a number of frames proportional to its size. If a process of size $s_i$ is allocated $f_i$ frames, then:
$
  f_i = s_i / (sum s_j) * m
$
where $m$ is the total number of frames available.

==== Global vs Local Allocation

When the allocated frames are full, the frame chosen to be replaced can be selected from either the entire set of frames (global allocation) or only from the frames allocated to that process (local allocation).

In global allocation, a process can replace a frame allocated to another process, even if it belongs to another process. Thus, it allows processes to steal frames from others and the total memory is treated as one shared pool. It has a higher overall throughput#footnote[Since the OS chooses the best possible victim frame globally] and better memory utilisation. However, it can lead to unpredictable execution times and harder to provide fairness or guarantees to individual processes.

In local allocation, a process can only choose a replacement frame from its own allocated frames. Thus, it provides more predictable execution times and fairness among processes. However, it can lead to lower overall throughput and poor memory utilisation since some processes may have unused frames while others are starved for frames.

#thmbox(
  variant: "Non-Uniform Memory Access",
  title: "",
  numbering: none,
)[
  The assumption that all frames are equally accessible is not valid in modern multi-processor systems with Non-Uniform Memory Access (NUMA) architectures. In NUMA systems, memory is divided into multiple regions, each associated with a specific processor. Accessing memory within the same region is faster than accessing memory in other regions. Thus, frame allocation strategies must consider the locality of memory access to optimize performance.
]

== Thrashing

#grid(
  columns: (2fr, 3fr),
  gutter: 10pt,
  figure(
    image("imgs/Thrashing.png"),
  ),
  [
    It is a performance problem in a virtual memory system where the CPU spends most of its time swapping pages in and out of memory instead of executing actual process instructions. It happens when the working set of processes exceeds the available physical memory, leading to a high rate of page faults.
  ],
)

Now, this can also be caused by the CPU scheduler, i.e. it tries to allocate too many processes to the CPU, leading to each process getting too little time to execute before being swapped out again.

=== Working Set Model

It is a technique used by the OS to determine the minimum number of pages needed by each process to avoid excessive page faults. It is based on the concept of _locality of reference_, which states that processes tend to access a small set of pages repeatedly over a short period of time.

For a given process, its working set at some time $t$ is given by,
$
	"WS"(t, Delta) = "the set of pages referenced during the last" Delta "time units"
$
Here, $Delta$ is the working-set window which is a fixed number of page references. The $"WSS"_i$ is the size of the working set of process $P_i$. The total demand for frames is given by,
$
  "D" = sum "WSS"_i
$
We compare $D$ with the total number of available frames $m$. If $D > m$, then thrashing occurs otherwise there are enough frames to allow all processes to run.

Choosing the window size is also pretty important. If $Delta$ is too small, meaning too few pages in the working set causing, not capturing the entire locality of reference, leading to more page faults. If $Delta$ is too large, meaning too many pages in the working set causing, it may include pages that are not currently needed, leading to inefficient memory usage.

=== Page Fault Frequency (PFF)

It is a dynamic, feedback-based approach to control the degree of multiprogramming in a system. The OS monitors the page fault rate of each process and adjusts the number of frames allocated to it based on its page fault frequency.

Unlike the working set model, it does not require tracking the entire working set of each process, making it easier to implement. However, it may not capture the full locality of reference of a process, leading to suboptimal frame allocation.

The OS sets upper and lower bounds on the acceptable page fault rate. If a process's page fault rate exceeds the upper bound, the OS allocates more frames to it. If the page fault rate falls below the lower bound, the OS deallocates some frames from it. Moreover, if the system cannot allocate more frames to a process, it may suspend the process until enough frames become available.
