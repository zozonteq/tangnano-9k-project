module top(
    input        clk,     
    input        btn1,    
    output       clock_out,
    output [5:0] led    
);

    reg [24:0] count;

    always @(posedge clk) begin
        if (!btn1) begin
            count <= count + 1'b1;
        end else begin
            count <= 0; 
        end
    end

   
    assign clock_out = count[22];

 
    assign led = ~count[24:19];
endmodule