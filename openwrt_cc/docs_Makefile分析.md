# docs/Makefile

��Openwrt��docsĿ¼���й��̱��롢���õ���ص�˵���ĵ������ǿ��԰����Ǳ����һ
��pdf�ȸ�ʽ���ļ����������������Ķ����ҵĻ�����Ubuntu�����Ǳ����ʱ�򣬻ᱨlatex��
pdflatex��tex4ht�ȹ���δ�ҵ���������Ҫͨ���������������װ��Щ���ߣ�
apt-get install texlive
apt-get install tex4ht

Ȼ�����ͻ�����openwrt.pdf��openwrt.html��openwrt.css�������ļ�

make docs/compile -j1 V=s
