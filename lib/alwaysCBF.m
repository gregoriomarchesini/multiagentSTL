function barrierFunction = alwaysCBF(predicateFunction,stateDimension,timeInterval,options)
arguments
    predicateFunction casadi.Function
    stateDimension    (1,1) double {mustBeInteger(stateDimension),mustBeNonnegative(stateDimension)}
    timeInterval      (1,2) double {mustBePositive(timeInterval)}
    options.type      (1,1) string {mustBeMember(options.type,["exp"])}="exp"
end

if timeInterval(2)<timeInterval(1)
    error("time interval must be non decreasing")
end

% create herethe variables that you need
systemState = casadi.SX.sym('systemState',stateDimension,1);
t = casadi.SX.sym('t',1);


if strcmp(options.type,"exp")
    toleranceToZero = 10^(-6);
    rho0 = toleranceToZero/exp(-timeInterval(1)); % chosen so that the exponential has value 10^-6 at timeIntervale(1)
    timeTransientFunction = casadi.Function('transient',{t},{rho0*exp(-t)});
end
    barrierFunction = casadi.Function('barrierTypeG',{systemState,t},{timeTransientFunction(t) + predicateFunction(systemState)},{'state','time'},{'CBF'});
end