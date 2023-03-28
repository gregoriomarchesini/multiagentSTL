function CBFConstraintFunction = CBFConstraint(cbf,systemDynamics,alphaFunction,stateDimension,controlDimension)
% The cbf is assumed to be a functon of time and the state
% CBF is assumed to be a function in the form CBF(state,t)
% the dynamics is assumed to be a function in the form f(state,t,control)
% the order does matter

arguments
    cbf casadi.Function
    systemDynamics casadi.Function
    alphaFunction  casadi.Function
    stateDimension (1,1) double {mustBeInteger(stateDimension),mustBePositive(stateDimension)}
    controlDimension (1,1) double {mustBeInteger(controlDimension),mustBePositive(controlDimension)}
end

t = casadi.SX.sym('time',1,1)    ;                   % introduce time variable
systemState  = casadi.SX.sym('state',stateDimension,1); % introduce state variable
controlInput = casadi.SX.sym('control',controlDimension,1); % introduce state variable

% differentiation 
partialTimeDiffcbf = jacobian(cbf(systemState,t),t); % partial derivative wrt time
nablaCBF           = jacobian(cbf(systemState,t),systemState); % gradient of the cbf
CBFConstraintFunction = casadi.Function('CBFconstraint', {systemState,t,controlInput},{partialTimeDiffcbf + dot(nablaCBF',systemDynamics(systemState,t,controlInput)) +  alphaFunction(cbf(systemState,t))},{'state','time','input'},{'CBF constraint'});
end