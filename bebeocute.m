img = imread('brain17.jpg');
bw = im2bw(img, 0.7);
label = bwlabel(bw);

stats = regionprops(label, 'Solidity', 'Area');
denisty = [stats.Solidity];
area = [stats.Area];

high_dense_area = denisty > 0.5;
max_area = max(area(high_dense_area));
tumor_label = find(area == max_area);
tumor = ismember(label, tumor_label);

se = strel('square',5);
tumor = imdilate(tumor,se);

figure(2)

subplot(1,3,1)
imshow(img, [])
title('brain')

subplot(1,3,2)
imshow(tumor,[])
title('tumor')

[B,L] = bwboundaries(tumor,'noholes');
subplot(1,3,3)
imshow(img,[])
hold on

for i = 1:length(B)
    plot(B{i}(:,2), B{i}(:,1), 'y','linewidth',1.75)
end
title('output')
hold off
    