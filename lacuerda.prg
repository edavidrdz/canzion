	url = "http://m.lacuerda.net/iapp.php?v=2.0&t=proc0131"
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
	                        b=1
	                        a1 = 1
	                        DO WHILE a1 = 1
	                        	a1=0
	                        	IF LEN(SUBSTR(a,AT_c("res.body += '",a,b))) > 0 then
	                        		b = b+1
	                        		a1 = 1
	                        	endif
	                        enddo
	                        coincidencias = b-1
	                        b=1
	                        concentrado = ''
	                        DO WHILE b <= coincidencias
	                        	ini = AT_c("res.body += '",a,b)
	                        	fin = AT_c("\n';",a,b)
	                        	linea = SUBSTR(a,ini, fin-ini+1)
	                        	uno = SUBSTR(linea, 14, (LEN(TRIM(linea))-14))
	                        	*dos2 = SUBSTR(linea, AT_c(":",linea,1)+2,AT_c("'",linea,5))
	                        	IF LEN(TRIM(uno)) > 2 then
		                        	concentrado = concentrado + CHR(13)+uno
	                        	endif
	                       		b = b+1
	                        ENDDO
	                        con = STRTRAN(concentrado, '<A>', '')
	                        con = STRTRAN(con, '</A>', '')
							con = STRTRAN(con,'á', '�')
							con = STRTRAN(con,'é', '�')
							con = STRTRAN(con,'�*', '�')
							con = STRTRAN(con,'ó', '�')
							con = STRTRAN(con,'ú', '�')
							con = STRTRAN(con,'�', '�')
							con = STRTRAN(con,'É', '�')
							con = STRTRAN(con,'�', '�')
							con = STRTRAN(con,'Ó', '�')
							con = STRTRAN(con,'Ú', '�')
							con = STRTRAN(con,'ñ', '�')
							con = STRTRAN(con,'Ñ', '�')
							con = STRTRAN(con,'º', '�')
							con = STRTRAN(con,'ª', '�')
							con = STRTRAN(con,'¿', '�')
	                        ?con
	                ENDIF
	        ENDIF
	ENDWITH
