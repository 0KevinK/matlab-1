%
%
%

function choice = main();
    meny();
    degree=[];
    points=[];
    while true
        choice = input('\nVälj ett menyval')
        if choice == 1
            askdegree();
        elseif choice == 2
            askpoints();
        end
    if ~isempty(degree) && ~isempty(points)
        if choice == 3
        end
    end
end
