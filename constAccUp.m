function dy = constAccUp(t,y, V0, W0)
		% motion formula in ENU coordinate system.
		% V0 - ��ʼ�ؼ��ٶ�
		% W0 - �����Ǳ仯�ٶ�.
		dy = zeros(6,1);    % a column vector : ve vn vu pe pn pu
		% A0 = 2;
		% beta = 50;
		D2R = pi/180;
		dy(1) = 0;
		dy(2) = 0;
		dy(3) = V0 * W0;
		dy(4) = y(1);
		dy(5) = y(2);
		dy(6) = y(3);
end

