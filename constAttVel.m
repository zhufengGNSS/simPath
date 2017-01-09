function dy = constAttVel(t, y, W0)
		% motion formula in ENU coordinate system.
		% W0 - ����� ������ ��ת�� �仯�ٶ�.
		dy = zeros(6,1);    % a column vector : ve vn vu pe pn pu
		dy(1) = 0;
		dy(2) = 0;
		dy(3) = 0;
		dy(4) = W0(1);
		dy(5) = W0(2);
		dy(6) = W0(3);
end

