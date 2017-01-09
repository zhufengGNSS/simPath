function dy = constAccFlat(t,y, A0, phi)
		% motion formula in ENU coordinate system.
		% phi - 航向角
		% A0 - 平飞加速度
		dy = zeros(6,1);    % a column vector : ve vn vu pe pn pu
		% A0 = 2;
		% beta = 50;
		D2R = pi/180;
		dy(1) = A0 * cos(phi * D2R);
		dy(2) = A0 * sin(phi * D2R);
		dy(3) = 0;
		dy(4) = y(1);
		dy(5) = y(2);
		dy(6) = y(3);
end