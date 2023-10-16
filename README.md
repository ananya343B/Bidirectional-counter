# Bidirectional-counter

A bidirectional counter is a digital electronic circuit that can count in both the upward and downward directions. It can increment or decrement its count based on the control signals it receives. This type of counter is often used in applications where you need to keep track of events or values that can change in both directions, such as measuring positive and negative changes in a process or monitoring the position of an object moving back and forth. Bidirectional counters are commonly implemented using flip-flops and logic gates to control the counting direction.

**Components**

1. **Flip-Flops:** A 4-bit bidirectional counter consists of four flip-flops, each representing one bit of the counter. These flip-flops store the current count value.

2. **Count Direction Control:** The counter has two control inputs: an "Up" signal and a "Down" signal. When "Up" is active, the counter increments, and when "Down" is active, it decrements. In this case we have taken a single signal which corresponds to 'Up' when high and 'down' when low.

3. **Clock Input:** The counter uses a clock signal to synchronize its operations. All flip-flops change their states on the rising or falling edge of the clock signal, depending on the specific design.

**Working**

1. **Initialization:** The counter is initialized with an initial value. This value represents the starting count.

2. **Counting Direction Control:** Depending on whether you want to count up or down, you set the "Up" or "Down" control signal. The counter will then count in the specified direction with each clock pulse.

3. **Counting Operation:**
   - When counting up, on each rising (or falling) edge of the clock, the counter increments its current value by 1. This is achieved by routing the carry-out from one flip-flop to the carry-in of the next.
   - When counting down, the counter decrements the current value by 1 on each clock pulse. This is done by using the borrow-out from one flip-flop to the borrow-in of the next.

4. **Overflow and Underflow Detection:** There should be logic that detects when the counter reaches its maximum value (overflow) or goes below zero (underflow). When an overflow or underflow condition is detected, the counter may wrap around to its minimum or maximum count value or trigger an output signal to indicate the condition.

5. **Output Display:** The current count, represented by the outputs of the four flip-flops, is typically displayed on a visual display device or used in further digital processing.

The synchronous nature of the counter ensures that all bits change simultaneously on each clock edge, which can be advantageous in applications requiring precise and synchronized counting. The control signals allow you to specify the counting direction, making this counter versatile for a wide range of applications, including motor control, position sensing, and many others.


We will be applying the ASIC flow to a bidirectional counter.

### LAB

**Installation steps**

```git clone https://github.com/YosysHQ/yosys.git```

```cd yosys```

```sudo apt install make```

```sudo apt-get update```

```sudo apt-get install build-essential clang bison flex libreadline-dev gawk tcl-dev libffi-dev git graphviz xdot pkg-config python3 libboost-system-dev libboost-python-dev libboost-filesystem-dev zlib1g-dev```

```make config-gcc```

```make```

```sudo make install```

```sudo apt install gtkwave```

```sudo apt install iverilog```

##### Adding design file and testbench

```mkdir vsd```

```cd vsd```

```https://github.com/kunalg123/sky130RTLDesignAndSynthesisWorkshop.git```

Open the folder ```sky130RTLDesignAndSynthesisWorkshop``` in ```vsd``` directory

Open the folder ```verilog_files```. This folder contains all the design files.

![one](https://github.com/ananya343B/Bidirectional-counter/assets/142582353/0cdd5f66-b811-48bf-9d98-cc83515341f2)

We will be adding our design file ```pes_bc.v``` and testbench file ```pes_bc_tb.v``` in this folder.

![two](https://github.com/ananya343B/Bidirectional-counter/assets/142582353/7f99b3ee-638e-47aa-8625-aea8c8f3305b)


##### iVerilog and GTKwave

Load the source code and testbench to iverilog simulator

```iverilog pes_bc.v pes_bc_tb.v```

Output file ```a.out``` is created

```./a.out```

![three](https://github.com/ananya343B/Bidirectional-counter/assets/142582353/bae86d62-49d6-4a46-aad8-9ee8334b7372)


Load the vcd file to gtkwave simulator

```gtkwave pes_bc_tb.vcd```

Gtkwave results:

![four](https://github.com/ananya343B/Bidirectional-counter/assets/142582353/03d0c02d-eb45-4655-9a5b-2407239c1410)

Zoomed in:

![zoomed_gtk](https://github.com/ananya343B/Bidirectional-counter/assets/142582353/c13314ca-5788-43dc-83d0-90a0b1328a29)

##### Yosys

Invoke yosys

![yosys_invoke](https://github.com/ananya343B/Bidirectional-counter/assets/142582353/300b3431-baea-4507-b140-21f0052a5edc)

Read the library

```read_liberty -lib ../lib/sky130_fd_sc_hd__tt_025C_1v80.lib```

Read thedesign

```read_verilog pes_bc.v```

Synthesise the module

```synth -top pes_bc```

![five](https://github.com/ananya343B/Bidirectional-counter/assets/142582353/a363c269-6dfd-4974-979e-aef6515916a4)


![six](https://github.com/ananya343B/Bidirectional-counter/assets/142582353/06cd7b54-e3f4-4dec-a968-6f2344ef3fe7)

Generating netlist:

```abc -liberty ../lib/sky130_fd_sc_hd__tt_025C_1v80.lib```

![seven](https://github.com/ananya343B/Bidirectional-counter/assets/142582353/6099f543-2e08-4a37-a4a7-c553d1454272)

```show```

![eight](https://github.com/ananya343B/Bidirectional-counter/assets/142582353/ef24066a-442a-454c-963c-a1814ee196f5)

To write the netlist:

```write_verilog pes_bc_netlist.v```

```!gvim pes_bc_netlist.v```

![ten](https://github.com/ananya343B/Bidirectional-counter/assets/142582353/eb1a639c-d8b2-4fed-880b-4482156b6789)

![nine](https://github.com/ananya343B/Bidirectional-counter/assets/142582353/89b90038-3f9f-4c08-9199-8f3e0c4464a7)
