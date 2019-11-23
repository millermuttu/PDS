X =[];
category = [];

plot(data_intensity','DisplayName','data_intensity')
back = data_intensity(1,:);
trans = data_intensity./repmat(back,size(data_intensity,1),1);
x=trans(2:end,:);
X=[X;x];
categr = 2*ones(size(x,1),1);
category= [category;categr];
% x_test = X;
save('masterUA','X','category');
