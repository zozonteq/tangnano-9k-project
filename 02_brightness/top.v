module top (
    input  clk,
    input  btn1,     
    input btn2,
    output [5:0] led // LED出力
);
    // registers ======================================================
    reg [5:0]  led_status = 6'b111111;
    reg [24:0] counter = 25'b0;
    reg [7:0] brightness = 0; // brightness level 0-255
    reg [7:0] brightnes_counter = 0; // PWM制御用
    // assignments ====================================================
    assign led = led_status;
    // main logic =====================================================
    always @(posedge clk) begin
        counter <= counter + 30;
        
        if(counter >= 24'd1349_9999) begin
            counter <= 0;
            if(~btn1 && ~btn2) begin 
                brightness <= 0;
            end else if(~btn1) begin
                brightness <= brightness + 1; // increment value
            end else if(~btn2) begin
                brightness <= brightness -1; // decrement value
            end
        end
        brightnes_counter <= brightnes_counter + 1;
        if(brightnes_counter < brightness) begin
           led_status <= 6'b111111; // turn off
           
        end else begin
            // led_status <= brightness; // turn on
            led_status <= 6'b000000;
        end

    end

endmodule