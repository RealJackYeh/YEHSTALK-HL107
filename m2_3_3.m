s=tf('s'); Ts=1/4000;
wsc=100; J=0.00016;  % 速度环帶寬wsc=100 rad/s
Kp_w=J*wsc; Ki_w=Kp_w*wsc/5; % 設計PI控制器的Kp, Ki值
K1 = 1; K2 = 0.1; K3 = 10; % 不同回路增益
tf_pi=tf([Kp_w Ki_w],[1 0]); % PI控制器
tf_plant=tf(1,[J 0]); % 受控廠
tf_currLoop = tf(1000, [1 1000]); % 電流环設計為帶寬為1000 rad/s的低通濾波器
Go_w_K1= K1*tf_pi*tf_currLoop*tf_plant; % 計算開环傳遞函數
Go_w_K2= K2*tf_pi*tf_currLoop*tf_plant; % 計算開环傳遞函數
Go_w_K3= K3*tf_pi*tf_currLoop*tf_plant; % 計算開环傳遞函數
h=bodeoptions;
h.PhaseMatching='on';
h.Title.FontSize = 14;
h.XLabel.FontSize = 14;
h.YLabel.FontSize = 14;
h.TickLabel.FontSize = 14;
bodeplot(Go_w_K1,'-k',Go_w_K2,'-g', Go_w_K3,'-b' ,{1,10000},h);
legend('Gain = 1','Gain = 0.1', 'Gain = 10');
h = findobj(gcf,'type','line');
set(h,'linewidth',2);
grid on;