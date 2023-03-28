function barrierFunction = eventuallyCBF(predicateFunction,stateDimension,timeInterval,options)
arguments
    predicateFunction casadi.Function
    stateDimension     (1,1) double {mustBeInteger(stateDimension),mustBeNonnegative(stateDimension)}
    timeInterval       (1,2) double {mustBePositive(timeInterval)}
    options.type       (1,1) string {mustBeMember(options.type,["exp"])}="exp"
    options.timeOfSatisfaction       (1,1) double {mustBePositive(options.timeOfSatisfaction)} = timeInterval(2) % put the slackest possible option sd default
end

if timeInterval(2)<timeInterval(1)
    error("time interval must be non decreasing")
end
if options.timeOfSatisfaction < timeInterval(1) || options.timeOfSatisfaction > timeInterval(2)
    error("time interval outside bounds. Must be included in t_0 = %0.2f and t_1 = %0.2f",timeInterval(1),timeInterval(2));
end

% create herethe variables that you need
systemState = casadi.SX.sym('systemState',stateDimension,1);
t = casadi.SX.sym('t',1);


if strcmp(options.type,"exp")
    toleranceToZero = 10^(-6);
    rho0 = toleranceToZero/exp(-options.timeOfSatisfaction); % chosen so that the exponential has value 10^-6 at timeIntervale(1)
    timeTransientFunction = casadi.Function('transient',{t},{rho0*exp(-t)});
end
    barrierFunction = casadi.Function('barrierTypeG',{systemState,t},{timeTransientFunction(t) + predicateFunction(systemState)},{'state','time'},{'CBF'});
end