module top (
    input  clk,
    input  btn1,     
    input btn2,
    output [5:0] led // LED出力
);
    // registers ======================================================
    reg [5:0]  led_status = 6'b111111;
    reg [24:0] counter = 25'b0;
    reg [5:0] value = 0;
    // assignments ====================================================
    assign led = led_status;
    // main logic =====================================================
    always @(posedge clk) begin
        counter <= counter + 3;
        if(counter >= 24'd1349_9999) begin
            counter <= 0;
            if(~btn1 && ~btn2) begin 
                value <= 0;
            end else if(~btn1) begin
                value <= value + 1; // increment value
            end else if(~btn2) begin
                value <= value -1; // decrement value
            end
        end
        led_status <= value;

    end

endmodule