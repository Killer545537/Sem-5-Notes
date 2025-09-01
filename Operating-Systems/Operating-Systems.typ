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

*File Management System* is a crucial component of an operating system that provides a way to store, organize, and manage data on storage devices. It offers a hierarchical structure for organizing files and directories, allowing users to easily access and manipulate their data. The file management system is responsible for tasks such as file creation, deletion, reading, writing, and permissions management. It also abstracts the details of the underlying storage hardware, providing a consistent interface for applications to work with files.

*Protection and Security* are essential aspects of an operating system that ensure the integrity, confidentiality, and availability of data and resources. This includes implementing user authentication, access control mechanisms, and encryption to protect sensitive information from unauthorized access and attacks. *Protection* is any mechanism for controlling access of processes or user resources defined by the OS. *Security* is the defence of the system against internal and external attacks.

#definition[Program][
  A program is a set of instructions that a computer can execute to perform a specific task. It is typically written in a high-level programming language and must be translated into machine code before it can be run by the CPU.
]
#definition[Process][
  A process is an instance of a program in execution. It includes the program code, its current activity, and the resources allocated to it, such as memory and file handles. The operating system manages processes to ensure that they have the necessary resources and can execute concurrently without interfering with each other.
]
Thus, a program is a passive entity while a process is an active entity that is being executed by the CPU. A single program can have multiple processes running simultaneously, each with its own state and resources.

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
There are essentially 5 groups of system calls:
- *Process Control:* These system calls manage processes, including creating, terminating, and synchronizing processes.
- *File Management:* These system calls handle file operations, such as creating, deleting, reading, and writing files.
- *Device Management:* These system calls manage device operations, including requesting and releasing device access.
- *Information Maintenance:* These system calls provide information about the system, such as system time and process status.
- *Communication:* These system calls facilitate communication between processes, including message passing and shared memory.
