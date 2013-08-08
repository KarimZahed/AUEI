function [ E_oh ] = OkumuraHata(freq, h1,h2,dist )
%OKUMURA-HATA Method found in Annex 8 

a=(1.1*log10(freq)-0.7)*h2-(1.56*log10(freq)-0.8);

h1_prime = h1 / sqrt( 1+ 0.000007*h1*h1); 

if dist<=20
    b=1;
else 
    b=1+(0.14+0.000187*freq+0.00107*h1_prime)*(log10(0.05*dist))^(0.8);
end 

E_oh=69.82-6.16*log10(freq)+13.82*log10(h1)+a-(44.9-6.55*log10(h1))*(log10(dist))^b;

end

