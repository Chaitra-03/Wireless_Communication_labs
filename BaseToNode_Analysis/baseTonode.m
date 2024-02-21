clc
clear all
close all

% Define the field size
field_size = [100 100];

% Define the base station location
base_station = [50 50];

f = 900*(10^6);
fraunhoferDistance = 10;
c = 3*(10^8);
wavelength = c/f;
transmitt_power=10;
gt = 1;
gr = 1;

% 1. Take user input for the number of nodes
n = input("Enter no of nodes: ");

% Generate random points
nodex = randi([1, field_size(1)], 1, n);
nodey = randi([1, field_size(2)], 1, n);

% Store the points in an array
node = [nodex; nodey];

locations = [base_station; node.'];

% Initialize a (n+1) x (n+1) matrix to store the distances
distances = zeros(n+1,n+1);

% Calculate the distances
for i = 1:n+1
    for j = 1:n+1
        distances(i,j) = sqrt((locations(i,1) - locations(j,1))^2 + (locations(i,2) - locations(j,2))^2);
    end
end

% Display the distances
disp('Distances:');
disp(distances);

% Initialize colors for nodes
node_colors = cell(1, n+1);
node_colors{1} = 'ro'; % Base station is always red

% Calculate received powers for each node
received_powers = zeros(n+1, 1);
for i = 2:n+1
    if distances(1,i) <= fraunhoferDistance
        % Near field device (LOS)
        node_colors{i} = 'bo'; % Blue color for near field devices
        received_powers(i) = 0; % Power is 0 for near field devices
    else
        % Far field device (NLOS)
        node_colors{i} ='go'; % Green color for far field devices
        % Calculate power using Friis equation considering reflections
        received_powers(i) = (10 * transmitt_power * gt * gr * (wavelength^2)) / ((4 * pi * distances(1,i))^2);
    end
end

% Plot the field
figure;
plot([0, field_size(1), field_size(1), 0, 0], [0, 0, field_size(2), field_size(2), 0], 'k-');
hold on;

% Plot the base station
scatter(base_station(1), base_station(2), 'ro', 'filled');

% Plot the nodes
for i = 2:n+1
    scatter(node(1,i-1), node(2,i-1), node_colors{i});
end

% Plot Fraunhofer distance
viscircles([base_station(1), base_station(2)], fraunhoferDistance, 'Color', 'r', 'LineWidth', 0.5);
viscircles([base_station(1), base_station(2)],40,'Color','b', 'Linewidth', 0.5)

% Set axis limits and labels
axis([0 field_size(1) 0 field_size(2)]);
xlabel('X');
ylabel('Y');
title('Square Field with Base Station and Nodes');

% Show the grid
grid on;

% Display received powers
disp('Received Powers:');
disp(received_powers);
