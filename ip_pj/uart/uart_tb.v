// IP: UART
// Ver: 0.1 (2025/7/7)
// Copyright (c) 2025 Chimipupu(https://github.com/Chimipupu) All Rights Reserved.

// UARTテストベンチ(115200 8N1)
module tb_uart;
    reg clk = 0;
    reg rst = 1;
    reg tx_start = 0;
    reg [7:0] tx_data = 8'h00;
    wire tx;
    wire tx_busy;

    wire [7:0] rx_data;
    wire rx_done;

    reg [7:0] tx_ascii;
    reg [7:0] rx_ascii;

    uart_tx #(.CLK_FREQ(50000000), .BAUD_RATE(115200)) uut_tx (
        .clk(clk), .rst(rst), .tx_start(tx_start), .tx_data(tx_data), .tx(tx), .tx_busy(tx_busy)
    );

    uart_rx #(.CLK_FREQ(50000000), .BAUD_RATE(115200)) uut_rx (
        .clk(clk), .rst(rst), .rx(tx), .rx_data(rx_data), .rx_done(rx_done)
    );

    always #10 clk = ~clk; // 50MHz

    always @(*) begin
        tx_ascii = (tx_data >= 8'd32 && tx_data <= 8'd126) ? tx_data : 8'h2E;
        rx_ascii = (rx_data >= 8'd32 && rx_data <= 8'd126) ? rx_data : 8'h2E;
    end

    initial begin
        $dumpfile("uart_tb.vcd");
        $dumpvars(0, tb_uart);

        $monitor("(%0t ns) | TX Data: %c(%02h) | RX Data: %c(%02h), RX_DONE: %b",
                $time,
                tx_ascii,
                tx_data,
                rx_ascii,
                rx_data,
                rx_done);

        #100;
        rst = 0;
        #100;

        send_string("UART IP TEST");

        #10000;
        $finish;
    end

    // 受信完了したタイミングで受信文字を表示
    always @(posedge clk) begin
        if (rx_done) begin
        $display("(%0t ns) RX DONE: '%c'(%02h)", $time,
                    (rx_data >= 32 && rx_data <= 126) ? rx_data : 8'h2E,
                    rx_data);
        end
    end

    task send_byte(input [7:0] data);
        begin
            @(posedge clk);
            wait (!tx_busy);
            tx_data = data;
            tx_start = 1;
            @(posedge clk);
            tx_start = 0;
            wait (!tx_busy);
        end
    endtask

    task send_string(input [8*20-1:0] str);
        integer i;
        begin
            for (i = 0; i < 20; i = i + 1) begin
                if (str[8*i +:8] != 8'h00) begin
                    send_byte(str[8*i +:8]);
                end
            end
        end
    endtask

endmodule