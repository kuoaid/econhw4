% Parameters
T = 40; % Working years
TR = 20; % Retirement years
lambda = 2; % Utility parameter

% Constants from production function
A = 1; % Production output multiplier
alpha = 0.3; % Capital's production elasticity

% Call the model equations
[c, h, k, utility, r, w] = model_equations(A, alpha, T, TR, lambda);

% Output results
fprintf('Rental Rate of Capital: %.4f\n', r);
fprintf('Wage Rate: %.4f\n', w);
fprintf('Total Capital: %.2f\n', sum(k));
fprintf('Age at Asset Peak: %d\n', find(k == max(k), 1));
fprintf('Lifetime Utility: %.2f utils\n', utility);
fprintf('Length of k: %d\n', length(k));
fprintf('Range for x-axis: %d to %d, Total points: %d\n', 0, T+TR, length(0:T+TR));
fprintf('Savings at Retirement: %.2f\n', k(T+1));

% Plotting
figure;
subplot(2,2,1);
plot(1:T+TR, c); % c has T+TR elements
title('Consumption Profile');
xlabel('Age');
ylabel('Consumption');

% Extend h to include zeros for the retirement period
h_extended = [h; zeros(TR, 1)];  % Assuming TR is 20, for retirement years

% Plotting
subplot(2,2,2);
plot(1:T+TR, h_extended); % Now h_extended has T+TR elements, which is 60
title('Labor Supply Profile');
xlabel('Age');
ylabel('Labor Supply');

% subplot(2,2,2);
% plot(1:T, h); % h has T elements, corresponding to working years only
% title('Labor Supply Profile');
% xlabel('Age');
% ylabel('Labor Supply');

subplot(2,2,3);
plot(1:T+TR, k); % Ensure that x-axis has T+TR points from 1 to T+TR
title('Assets Profile');
xlabel('Age from 1 to T+TR');
ylabel('Assets');

subplot(2,2,4);
bar([mean(k(T+2:T+TR)), mean(k(2:11))]); % Average of the retirement period assets and first 10 years
set(gca, 'XTickLabel', {'Retirement', 'First 10 Years'});
title('Wealth Inequality');
ylabel('Average Assets');
