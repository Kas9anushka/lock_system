<p style="color:red; font-size:16px;">Digital lock System</p>

<p style="color:blue; font-size:14px;">1. Description</p>

This module implements a 4-digit password-based locking system using FPGA push buttons 
and LEDs. The system allows a user to input a 4-symbol password sequence using two push 
buttons. Each button represents a binary input:
    • Button A 
    • Button B 
    
   The expected correct password format is: A A B B. 
   
User inputs are collected sequentially. After entering 4 inputs, the user toggles a lever switch to 
validate the entered password.

<p style="color:blue; font-size:14px;">2. FUNCTIONAL OVERVIEW</p>

<img width="658" height="362" alt="image" src="https://github.com/user-attachments/assets/e7c0a275-7b90-43b2-92ee-e3964e933447" />


<p style="color:blue; font-size:14px;">2.1 Input Method</p>

• Two push buttons (button_in[1:0]) are used: 
     o button_in[0] → Button A 
     o button_in[1] → Button B 
• Only one button press at a time is valid
• Each valid press is treated as one digit input

<p style="color:blue; font-size:14px;">2.2 Input Sequence Handling</p>  

• The system captures exactly 4 inputs in sequence
• After each valid input: 
         o Corresponding LED is turned ON (progress indicator)
         
<p style="color:blue; font-size:14px;">2.3 LED Behavior</p>  

Function LED[5:0]

<img width="694" height="404" alt="image" src="https://github.com/user-attachments/assets/50ff3082-82c1-44b8-bb91-425d2b3193f4" />


<p style="color:blue; font-size:14px;">2.4 Lever Operation (Validation Trigger)</p>  

• Lever acts as confirm signal
• When lever = 1, the system evaluates the password
• If password is correct, the lock is UNLOCKED
• If password is wrong, it resets the sequence

<p style="color:blue; font-size:14px;">2.5 Reset Behavior</p>  
• On rst = 1: 
      o Clear all stored inputs 
      o Turn OFF all LED
