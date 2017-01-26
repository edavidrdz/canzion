SET DEFAULT TO  c:\users\erik.rodriguez\dropbox\vfp\grupo\actualizacion\
SET PROCEDURE TO acces ADDITIVE
PUBLIC lis

CREATE CURSOR lstonos ;
(id n(2),;
tono c(5),;
ingles c(5);
)

tsql ='select * from tonos'
r = consulta_a(tsql)
IF r = 1
	SELECT cur 
	GO  top
	DO WHILE !EOF()
		SELECT lstonos
		APPEND BLANK
		replace id WITH cur.id
		replace tono WITH cur.tono
		replace ingles WITH cur.ingles
		
		SELECT cur
		SKIP
	enddo

endif