`default_nettype none 
module lock( 
    input wire [1:0]button_in,  
    input wire lever, clk, rst, 
    output reg [5:0]LED 
    ); 
    reg [1:0] btn_d;              
    wire btn_event;             
 
    reg [7:0] shi_reg;         
    reg [53:0] step_counter;   
  
    assign btn_event = (btn_d != button_in) || lever; 
    wire lock = (shi_reg != 8'b01011010); 
    always @(posedge clk or posedge rst) begin 
        if(rst || (lock && lever)) 
            btn_d <= 2'b00; 
        else 
            btn_d <= button_in; 
    end 
    always @(posedge clk or posedge rst) begin 
        if(rst) begin 
            shi_reg <= 8'b0; 
        end 
        else if(btn_event) begin 
                case(button_in) 
                    2'b00: shi_reg <= shi_reg; 
                    2'b01: shi_reg <= {shi_reg[5:0],2'b01}; 
                    2'b10: shi_reg <= {shi_reg[5:0],2'b10}; 
                    2'b11: shi_reg <= {shi_reg[5:0],2'b01}; 
                    default: shi_reg <= shi_reg; 
                endcase 
        end 
    end 
    always @(posedge clk or posedge rst) begin 
        if(rst) begin 
            step_counter <= 'b0; 
        end 
        else if(btn_event) begin 
            if(lever) begin 
                if(shi_reg == 8'b01011010) 
                    step_counter <= step_counter; 
                else 
                    step_counter <= 'b0; 
            end 
            else if(button_in == 2'b01 || button_in == 2'b10 || button_in == 2'b11) begin 
                step_counter <= step_counter + 1; 
            end 
        end 
    end 
    always @(posedge clk or posedge rst) begin 
        if(rst) begin 
            LED <= 6'b000000; 
        end 
        else if(!lever) begin 
            case(step_counter) 
                0: LED <= 6'b000000; 
                1: LED <= 6'b000001; 
                2: LED <= 6'b000011; 
                3: LED <= 6'b000111; 
                default: LED <= 6'b001111; 
            endcase 
        end 
        else if(lever) begin 
            if(shi_reg == 8'b01011010) 
                LED <= 6'b010000; 
            else 
                LED <= 6'b100000; 
        end 
        else 
            LED <= 6'b000000; 
    end 
endmodule 
