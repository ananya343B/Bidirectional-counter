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
STAGE 1: Physical design
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

**Magic**

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

![start1](https://github.com/ananya343B/Bidirectional-counter/assets/142582353/4782f6ba-4c07-4b82-88bb-84489010446c)

The ```config.json``` file is as follows:

![config_json](https://github.com/ananya343B/Bidirectional-counter/assets/142582353/7af4fd3b-e7cd-483d-8d23-741dc5a1d2ec)

We add the design file ```pes_bc.v``` in the ```src``` directory

![verilog_in_src](https://github.com/ananya343B/Bidirectional-counter/assets/142582353/02411d08-f77b-48b1-a508-1c97965b4c12)

#### Invoking Openlane

In the Openlane directory,

``` make mount```

```./flow.tcl -interactive```

This opens the Openlane shell in interactive mode

![openlane_open](https://github.com/ananya343B/Bidirectional-counter/assets/142582353/5352bad3-6b39-4fd7-a7d5-b8b23a4011b8)

#### Preparing the design and synthesis

```prep -design pes_bc```

![prep_design](https://github.com/ananya343B/Bidirectional-counter/assets/142582353/b231e069-7459-40b0-ae18-39924798c3fa)

```run_synthesis```

![run_synth](https://github.com/ananya343B/Bidirectional-counter/assets/142582353/c699a152-b25c-4e70-ba84-c5cfb05e063c)

We can find the following synthesis report file in

```Openlane/designs/pes_bc/runs/<latest_run>/reports/synthesis```

![synthesis_stat](https://github.com/ananya343B/Bidirectional-counter/assets/142582353/2d5b22af-b175-4754-8f59-ce59224f862a)

#### Floorplan

```run_floorplan```

![run_floorplan](https://github.com/ananya343B/Bidirectional-counter/assets/142582353/a89a66e6-e0e2-4476-b170-d30b15e42a84)


To view floorplan

```magic -T /home/ananyap/Desktop/sky130A.tech lef read ../../tmp/merged.nom.lef def pes_bc.def &``` 

in ```./designs/pes_bc/runs/<latest_run>/results/floorplan```

![floorplan0](https://github.com/ananya343B/Bidirectional-counter/assets/142582353/cfdd3ebb-5e08-41d4-af60-7e416a60055f)

![floorplan1](https://github.com/ananya343B/Bidirectional-counter/assets/142582353/4106500b-157c-4f17-9103-e8d6d28a5606)

![floorplan2](https://github.com/ananya343B/Bidirectional-counter/assets/142582353/9296ee91-405d-4aa1-959f-b9090d2e8fc1)

![floorplan3](https://github.com/ananya343B/Bidirectional-counter/assets/142582353/2e82b591-459d-4622-9390-1dd6bcb392ba)

#### Placement

```run_placement```

![run_placement](https://github.com/ananya343B/Bidirectional-counter/assets/142582353/ba3aa510-f805-4cee-a5fe-59a9a9d71b12)


To view placement

```magic -T /home/ananyap/Desktop/sky130A.tech lef read ../../tmp/merged.nom.lef def pes_bc.def &```

in ```./designs/pes_bc/runs/<latest_run>/results/placement```

![placement0](https://github.com/ananya343B/Bidirectional-counter/assets/142582353/035dacb4-a976-4923-be18-2f25b9885fcf)

![placement1](https://github.com/ananya343B/Bidirectional-counter/assets/142582353/d87395b3-a848-4756-8db8-37064fa1174b)

![placement2](https://github.com/ananya343B/Bidirectional-counter/assets/142582353/3972dee3-5e06-4085-b7aa-c7d99d6519f9)

![placement3](https://github.com/ananya343B/Bidirectional-counter/assets/142582353/ca9ff4ee-af0a-4cf8-9787-f65d55109ac9)


The following placement statistics can be found in

```Openlane/designs/pes_bc/runs/<latest run>/logs/placement```

![placement_stat1](https://github.com/ananya343B/Bidirectional-counter/assets/142582353/5f19907e-5c79-4e48-9600-16f11ffc51ed)

![placement_analysis](https://github.com/ananya343B/Bidirectional-counter/assets/142582353/25077527-af76-475b-bd74-4fc80cf4d6e2)


#### Routing

```run_routing```

![run_routing](https://github.com/ananya343B/Bidirectional-counter/assets/142582353/b5082452-9a08-4aab-8755-b397dea567be)

To view routing

```magic -T /home/ananyap/Desktop/sky130A.tech lef read ../../tmp/merged.nom.lef def pes_bc.def &```

in ```./designs/pes_bc/runs/<latest_run>/results/routing```

![routing0](https://github.com/ananya343B/Bidirectional-counter/assets/142582353/5caa6072-8f07-492d-9abd-1f53f4235858)

![routing1](https://github.com/ananya343B/Bidirectional-counter/assets/142582353/812d8d32-7651-42fb-a3c2-d4f02f9e81bf)

![routing2](https://github.com/ananya343B/Bidirectional-counter/assets/142582353/57173f3e-45bb-4231-9193-7548906b8f1f)

![routing3](https://github.com/ananya343B/Bidirectional-counter/assets/142582353/d550ff38-9687-4330-887d-53fc8a34f7ba)

Routing analysis:

![routing_analysis1](https://github.com/ananya343B/Bidirectional-counter/assets/142582353/80312dab-009b-4f2b-bc31-c5991c889e1b)

![routing_analysis2](https://github.com/ananya343B/Bidirectional-counter/assets/142582353/ae57f29d-c873-4f95-b958-b4f7f5cd6b5c)

Detailed routing 

![detailed_routing](https://github.com/ananya343B/Bidirectional-counter/assets/142582353/7717f9f5-c5da-4ad3-bb76-c3ece493b55f)

#### Clock tree synthesis

```run_cts```

![run_cts](https://github.com/ananya343B/Bidirectional-counter/assets/142582353/0e387f8f-479a-4f86-8d02-a9417c9077a4)


#### Automatic flow in Openlane:

```make mount```

```./flow.tcl -design <design name>```

![option2](https://github.com/ananya343B/Bidirectional-counter/assets/142582353/943d9fce-05f4-4059-b0aa-5cabd6c58e10)

Flow completion:

![flow_complete](https://github.com/ananya343B/Bidirectional-counter/assets/142582353/ec992682-de6f-4a4d-be63-f82b487c7801)


###### Power report

![power_report_synth](https://github.com/ananya343B/Bidirectional-counter/assets/142582353/aeb8d711-05ad-4cc3-b707-d6104d4f3c8c)


###### Area and congestion report

![area_report](https://github.com/ananya343B/Bidirectional-counter/assets/142582353/5480472f-5af7-4910-9faa-3a21cc1f9303)

![congestion_report](https://github.com/ananya343B/Bidirectional-counter/assets/142582353/796b72fd-29ba-4642-bb1b-372430204afe)


</details>





