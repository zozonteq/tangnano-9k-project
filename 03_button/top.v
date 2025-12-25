module top (
    input  clk,
    input  btn1,     
    input btn2,
    output [5:0] led // LED出力
);
    // registers ======================================================
    reg [1:0] mode = 0; // 0 == チャタリング対策なし
    reg [5:0]  led_status = 6'b111111;
    reg [1:0] btn_status = 2'b00;

    reg [23:0] counter = 0 ;
    // assignments ====================================================
    assign led = led_status;
    // main logic =====================================================
    always @(posedge clk) begin
        if(~(btn1 || btn2)) begin
            mode <= mode + 1;
        end
        led_status[3] <= mode[0];
        led_status[2] <= mode[1];

        // チャタリング未対策 toggle
        if(mode == 0) begin
            if(~btn1) begin
                if(~btn1 != btn_status[0]) begin
                    led_status[5] <= ~led_status[5];
                end
                btn_status[0] <= btn1;
            
            end
            
            if(~btn2) begin
                if(~btn2 != btn_status[1]) begin
                    led_status[0] <= ~led_status[0];
                end
                btn_status[1] <= btn2;
            end
        end
        // チャタリング対策版
        else begin
            counter <= counter + 1;
            if(counter >= 24'd49_9999) begin
                counter <= 0;
                if(~btn1) begin
                    if(btn1 != btn_status[0]) begin
                        led_status[5] <= ~led_status[5];
                    end
                    
                end
            
                if(~btn2) begin
                    if(btn2 != btn_status[1]) begin
                        led_status[0] <= ~led_status[0];
                    end
                    
                end
                btn_status[0] <= btn1;
                btn_status[1] <= btn2;
            end
        end
    end

endmodule