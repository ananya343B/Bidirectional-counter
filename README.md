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

![image](https://github.com/ananya343B/Bidirectional-counter/assets/142582353/924ff128-f69b-47ae-9b5d-50e0f9008ccc)


We will be applying the ASIC flow to a bidirectional counter.

### LAB
<details>  
<summary>  
STAGE 1: RTL Synthesis and GLS Simulation
</summary>
<br>

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

```git clone https://github.com/kunalg123/sky130RTLDesignAndSynthesisWorkshop.git```

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

**Gate Level Simulation**

```iverlog ../my_lib/verilog_model/primitives.v .//my_lib/verilog_model/sky130_fd_sc_hd.v pes_bc_netlist.v pes_bc_tb.v```

```./a.out```

```gtkwave pes_bc_out.vcd```

![ten](https://github.com/ananya343B/Bidirectional-counter/assets/142582353/8c2cb3d6-0931-41ed-be9b-4a3352e92cba)

![wave2](https://github.com/ananya343B/Bidirectional-counter/assets/142582353/ff2dc4e0-a0ea-41c7-a7be-609c780c06f9)

It can be observed that the waveform output of the functional simulation and the GLS are same. We can conclude that the netlist generated is correct.

</details>

<details>  
<summary>  
STAGE 1: Physican design
</summary>
<br>

##### Main stages in the physical design flow

1. Synthesis

2. Floorplanning

3. Powerplanning

4. Placement

5. Clock Tree Synthesis

6.Routing

7. Signoff

##### Installation of tools:

**Openlane and Docker**

Follow the steps in the below link to install [Docker](https://docs.docker.com/engine/install/ubuntu/)

To install [Openlane2](https://openlane.readthedocs.io/en/latest/getting_started/installation/installation_ubuntu.html)

**MAgic**

Follow the below steps to install **magic**

```
git clone https://github.com/RTimothyEdwards/magic  
$ sudo apt-get install m4  
$ sudo apt-get install tcl-dev  
$ sudo apt-get install tk-dev  
$ sudo apt-get install blt  
$ sudo apt-get install freeglut3  
$ sudo apt-get install libglut3  
$ sudo apt-get install libglu1-mesa-dev  
$ sudo apt-get install libgl1-mesa-dev  
$ sudo apt-get install csh  
$ ./configure  
$ make  
$ make install
```

#### Setup

In the Openlane designs directory, create a design directory ```pes_bc``` which has the following components:

'start 1'

The ```config.json``` file is as follows:

'config_json'

We add the design file ```pes_bc.v``` in the ```src``` directory

'verilog_in_src'

#### Invoking Openlane

In the Openlane directory,

``` make mount```

```./flow.tcl -interactive```

This opens the Openlane shell in interactive mode



