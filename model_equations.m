function [c, h, k, utility, r, w] = model_equations(A, alpha, T, TR, lambda, withSS)
    % Parameters
    delta = 0.1; % Assumed depreciation rate for more realistic modeling
    rho = 0.2; % Tax rate
    B = 0.2; % Social security benefit

    if withSS==0
        B = 0;
    end

    % Solve for equilibrium wage (w) and rental rate of capital (r)
    K = 5; % Total capital in economy, assume initial guess
    L = 3; % Total labor in economy, assume initial guess
    r = A * alpha * (L/K)^ (1-alpha) - delta; % From F1 condition
    w = A * (1-alpha) * (K/L)^alpha; % From F2 condition

    % Initialize vectors
    c = zeros(T+TR, 1); % Consumption profile
    h = zeros(T, 1); % Labor supply profile (only for working years)
    k = zeros(T+TR+1, 1); % Asset holdings profile, includes retirement

    % Iteratively calculate each year's consumption, labor, and assets
    for s = 1:T
        h(s) = 1; % Assume full employment during working years
        if s == 1
            k(s) = 0; % No initial capital
        end
        c(s) = (1 - rho) * w * h(s) + r * k(s); % Consumption
        k(s+1) = w * h(s) - c(s) + (1 - delta) * k(s); % Asset update
    end

    for s = T+1:T+TR
        c(s) = r * k(s) + B; % Retirement consumption
        k(s+1) = (1 + r) * k(s) - c(s); % Asset update in retirement
    end

    % Utility calculation, considering only working years for labor
    utility = sum(log(c(1:T) + lambda) - log(1)); % Simplified utility function

    % Correct the output
    c = c(1:T+TR); % Final consumption profile
    h = h(1:T); % Final labor supply profile
    k = k(1:T+TR); % Final asset holdings profile
end
