%
%
%

function choice = main();
    meny();
    degree=[];
    points=[];
    coeffs=[];
    while true
        choice = input('\nVälj ett menyval')
        if choice == 1
            degree= askdegree();
        elseif choice == 2
            points=askpoints();
        end
        if choice == 3
            if ~isempty(degree) || ~isempty(points)
           coeffs = findcoeffs(degree,points)
            else
        disp('Gradtal eller punter är inte definerat.')
       
            end
        end
    if ~isempty(degree) && ~isempty(points) && ~isempty(coeffs)
         if choice == 4
             plotpoly(coeffs,points);
        end
        if choice == 5
             polyroots(coeffs);
        end
             
    end
end
