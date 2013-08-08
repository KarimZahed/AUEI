function [ RAH_correction ] =RAHcorrection(freq, R2_prime,h1,h2,environment,PathType, AdjToSea )
%Equations from Annex 5, Section 9
%Receiving/Mobile Antenna Height Correction, 
 
if strcmpi(PathType,'land')
        if strcmpi(environment,'urban')||strcmpi(environment,'suburban')||strcmpi(environment,'small urban')||strcmpi(environment,'dense urban')
               % Correction for urban areas

                 if h2<R2_prime
                    Knu=0.0108*sqrt(freq);
                    hdif=R2_prime-h2;
                    theta_clut=atan(hdif/27)*180/pi;
                    v=Knu*sqrt(hdif*theta_clut);
                    Jv=(6.9+20*log10(sqrt(((v-0.1)^2)+1)+v-0.1));
                    RAH_correction=6.03-Jv;

                 else
                      Kh2=3.2+6.2*log10(freq);
                      RAH_correction=Kh2*log10(h2/R2_prime);
                 end

                  if R2_prime<10
                     Kh2=3.2+6.2*log10(freq);
                     RAH_correction=RAH_correction-Kh2*log10(10/R2_prime);
                  end

        elseif strcmpi(environment,'rural')||strcmpi(environment,'open')
            % Correction for open areas
                Kh2=3.2+6.2*log10(freq);
                R2_prime=10;%appl eq(28b) with R2'=10 see Figure 27 page 43
                RAH_correction=Kh2*log10(h2/R2_prime);									   
        else % if no environment specified, environment =0
            RAH_correction=0;
        end
elseif (AdjToSea==1 || strcmpi(PathType,'sea') || strcmpi(PathType,'WarmSea')||strcmpi(PathType,'ColdSea'))  % In case of sea ... BUT WHAT ABOUT ADJACENT TO SEA 
    
                  if h2>=10
                     Kh2=3.2+6.2*log10(freq);
                     RAH_correction=Kh2*log10(h2/10);
                  else
                      dh2=Fresnel(freq,h1,h2);
                      d10=Fresnel(freq,h1,10);
                      
                      if (dist>=d10)
                        Kh2=3.2+6.2*log10(freq);
                        RAH_correction=Kh2*log10(h2/10);
                      elseif d<= dh2
                          RAH_correction=0;
                      elseif (d<d10 && d>dh2)
                         Kh2=3.2+6.2*log10(freq);
                         C10=Kh2*log10(h2/10);
                         RAH_correction= C10 * log10(dist/dh2)/log10(d10/dh2);
                      end
                      
                  end 
end