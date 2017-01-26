url = "http://m.lacuerda.net/iapp.php?v=2.0&b=marcos_brunet"
SET MEMOWIDTH TO 120
#DEFINE ccUrl url
oHttp = CreateObject("WinHttp.WinHttpRequest.5.1")
WITH oHttp
        IF Not .Open("GET", ccUrl)
                ? "Error:", .ErrorCode, .ErrorMsg
        ELSE
                IF Not .Send()
                        ? "Error:", .ErrorCode, .ErrorMsg
                ELSE
                        CLEAR
                        a = .ResponseText
                        *?a
                        b=1
                        a1 = 1
                        DO WHILE a1 = 1
                        	a1=0
                        	IF LEN(SUBSTR(a,AT_c("t=",a,b))) > 0 then
                        		b = b+1
                        		a1 = 1
                        	endif
                        enddo
                        coincidencias = b-1
                        b=1
                        DO WHILE b <= coincidencias
                        	ini = AT_c("t=",a,b)
                        	fin = AT_c("}",a,b)
                        	linea = SUBSTR(a,ini, fin-ini)
                        	uno = SUBSTR(linea, 3,AT_c("'",linea,1)-3)
                        	dos2 = SUBSTR(linea, AT_c(":",linea,1)+2,AT_c("'",linea,5))
                        	?uno + "-"+dos2
                       		b = b+1
                        enddo
                ENDIF
        ENDIF
ENDWITH