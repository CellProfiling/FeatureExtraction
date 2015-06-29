A = rand(3);
B = ones(5);

try
  c = test_catch(A,B);
catch err
    disp('test');
end