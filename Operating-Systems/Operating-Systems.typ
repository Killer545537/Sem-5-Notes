#import "@preview/ilm:1.4.1": *
#import "@preview/physica:0.9.5": *
#import "@preview/thmbox:0.2.0": *
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge, shapes

#show: thmbox-init(counter-level: 2)
#set text(lang: "en")
#set figure(numbering: none)

#let definition-counter = counter("definition")
#show: sectioned-counter(definition-counter, level: 2)
#let definition = definition.with(counter: definition-counter)

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
  caption: [Interrupt Timeline]
)
When an interrupt occurs, it transfers control to the interrupt service routine (generally through the interrupt vector table) which contains the addresses#footnote[The CPU loads the ISR address into the _program counter_ and starts executing it] of all the service routines for different interrupt types.
The CPU preserves its state by saving the program counter and other registers onto the stack before executing the interrupt handler.
#figure(
  image("imgs/Interrupt-Driven-IO-Cycle.png"),
  caption: [Interrupt-Driven I/O Cycle]
)

There is also a hardware device, *timer*, built into the CPU that generates interrupts at fixed or programmable intervals. It lets the OS regain control of the CPU after a set period, preventing any single process from monopolizing the CPU.

#definition[System/Monitor Call][
  A system call is a request made by a program to the operating system to perform a specific task or service that the program does not have permission to execute directly. System calls provide a controlled interface for user programs to access hardware resources and services provided by the operating system.
]

== Storage Structure

#figure(
  image("imgs/Storage-Device-Hierarchy.png", height: 30%, fit: "contain"),
  caption: [Storage Device Hierarchy]
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

A large portion of the OS is devoted to managing I/O devices#footnote[Storage is also a type of I/O device] and operations. This includes device drivers, which are specialized software components that allow the OS to communicate with hardware devices. Device drivers provide a standard interface for the OS to interact with different types of hardware, abstracting the details of the hardware implementation. Each device controller, maintains a local buffer storage and a set of special registers, is in charge of a specific type of device. The CPU communicates with the device controller by reading and writing to these special registers.

#figure(
  image("imgs/Working-IO-Operation.png", height: 25%),
  caption: [Working of an I/O Operation]
)

== Computer System Architecture

Computer systems can be classified on the basis of the number of general-purpose processors:
- *Single Processor Systems:* These systems have one CPU that executes all tasks. They are simpler and easier to manage but may become bottlenecks for performance as the number of tasks increases.
- *Multiprocessor/Parallel/Tightly Coupled Systems:* These systems have multiple CPUs that can execute tasks concurrently, improving performance and responsiveness. They share a common memory and are connected by a bus or interconnection network. Multiprocessor systems can be further classified into symmetric multiprocessing (SMP) and asymmetric multiprocessing (AMP) systems.
  - *Symmetric Multiprocessing (SMP):* In SMP systems, all processors have equal access to memory and I/O devices, and they share the same operating system instance. This allows for better load balancing and resource utilization.
  - *Asymmetric Multiprocessing (AMP):* In AMP systems, each processor is assigned a specific task or set of tasks, and they may have their own operating system instances. This can lead to more efficient processing for certain workloads but may require more complex communication mechanisms between processors.
#figure(
  image("imgs/Mutiprocessor-Types.png"),
  caption: [Types of Multiprocessor Systems (SMP vs AMP)]
)
- *Clustered Systems:* These systems consist of multiple independent computers (nodes) that work together to perform tasks. They are connected through a high-speed network and can provide improved performance, fault tolerance, and scalability. These systems can be used for load balancing, high availability, and parallel processing and can be structured asymmetrically#footnote[Here, one machine in hot-standby mode while the other runs applications] or symmetrically#footnote[Here, $>2$ machines share the workload equally and monitor each other].

#definition[Dual-Core Design][
  A dual-core design refers to a single processor chip that contains two independent processing units (cores). Each core can execute instructions separately, allowing for true parallelism within a single physical processor. Dual-core (and multi-core) designs improve performance and efficiency by enabling multiple tasks or threads to be processed simultaneously, reducing bottlenecks compared to single-core processors. Modern CPUs often feature multiple cores to better handle multitasking and parallel workloads.
  #figure(
    image("imgs/Dual-Core-Design.png", height: 25%),
    caption: [Dual-Core Design]
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
  caption: [Operating System Services]
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
  caption: [Mode Bit Operation]
)

#definition[System Call][
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
  caption: [Virtualization Architecture]
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

It is responsible for loading the program into memory, setting up the stack and heap, and transferring control to the program's entry point. The loader may also perform additional tasks such as dynamic linking of shared libraries and relocation of code and data segments.

#figure(
  image("imgs/Linker-Loader.png", height: 25%),
  caption: [Role of Linker and Loader]
)
This kinda answers why applications are OS specific. The compiled code contains system calls and library calls specific to the OS, and the linker/loader must be able to handle these appropriately.

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
    caption: [Structure of the MS-DOS Operating System]
  ),
  [This is a very simple layered structure where each layer is built on top of the one below it. It works but just works. There is not much abstraction or separation of concerns. It is almost a single layer. The seperation is so bad that applications run in the same address space as the OS.]
)
