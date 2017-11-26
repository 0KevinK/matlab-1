%
%
%

function choice = main();
    meny();
    while true
        choice = input('\nVälj ett menyval')
        if choice == 1
            askdegree();
        elseif choice == 2
            askpoints();
        end
    if degree ~= false && points ~= false
        if choice == 3
        end
    end
end