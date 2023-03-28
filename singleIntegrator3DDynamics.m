clear
close
% Create the single integrator 3D dynamics
dummy1D     = casadi.SX.sym('dummy');
systemState = casadi.SX.sym('state',3,1);
control     = casadi.SX.sym('control',3,1); 
t           = casadi.SX.sym('time',1);
dynamics    = casadi.Function('singleIntegratorDynamics',{systemState,t,control},{control},{'state','control','time'},{'df'});

% create a predicate function (this function is always only a function of the state and not of time)
interestPoint = [-8;0;0]
predicate     = casadi.Function('predicate',{systemState},{5^2 - (systemState-interestPoint )'*(systemState-interestPoint)});
CBFfunction   = eventuallyCBF(predicate,3,[5,10]);
alpha         = casadi.Function('alpha',{dummy1D},{3*dummy1D});

constraint = CBFConstraint(CBFfunction,dynamics,alpha,3,3);

% 
% qp = struct('x',control, 'f',control'*control, 'g',constraint([1;1;1],0,control));
% S = casadi.qpsol('S', 'ipopt', qp);
% disp(S)
timeSpan = linspace(0,13,20);
solution = zeros(3,length(timeSpan));
counter = 1;

for t = timeSpan
    opti = casadi.Opti();
    x = opti.variable(3,1);
    opti.minimize(  x'*x   );
    opti.subject_to( constraint([5;1;1],0,x)>=0 );
    opti.solver('ipopt');
    sol = opti.solve();
    solution(:,counter) = sol.value(x);
    counter = counter+1;
end

figure
plot(solution')








