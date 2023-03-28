clear all
close all

systemState = casadi.SX.sym('systemState',3,1);
predicate   = casadi.Function('predicate',{systemState},{5^2 - (systemState-[0;0;0])'*(systemState-[0;0;0])});
CBF         = eventuallyCBF(predicate,3,[5,10]);
u = casadi.SX.sym('u',1,1)
state = casadi.SX.sym('x',3,1)
t = casadi.SX.sym('t')
dynamics = casadi.Function('singleIntegrator',{state,t,u},{[u;u;u]})
alpha = casadi.Function('alpha_0',{u},{3*u})
bb = CBFConstraint(CBF,dynamics,alpha,3,1)


x = SX.sym('u',3,1); y = SX.sym('y');
qp = struct('x',[x;y], 'f',x^2+y^2, 'g',x+y-10);
S = qpsol('S', 'qpoases', qp);
disp(S)