
*	xStrCon = "Driver={Microsoft Access Driver (*.mdb)};Dbq=C:\iafcj\fox.mdb;Uid=Admin;Pwd=;"
*	STORE SQLSTRINGCONNECT(xStrCon)to xControl
*	tsql = "select MAX(iddiesmos)as ma from diesmos"
*	sqlexec(xControl,tsql,"cur")
*	mas = cur.ma + 1
*	tsql = "Insert into diesmos (iddiesmos,fecha, idhno, di, of, asi, ev, en, ef)";
*		 + " values (?mas,DATE(), 3,500.00,1.00,1.00,1.00,1.00,600.00)"
*	r = sqlexec(xControl,tsql,"cur")
*	*tsql = "select * from diesmos"
*	*r = sqlexec(xControl,tsql,"cur")
*	MESSAGEBOX(R)
*	BROWSE
*	=SQLDISCONNECT(0)

*.. hacer consulta a Tabla
FUNCTION consulta_a
LPARAMETERS tsql
	xStrCon = "Driver={Microsoft Access Driver (*.mdb)};Dbq="+sys(2003)+"\grupo.mdb;Uid=;Pwd=;"
	STORE SQLSTRINGCONNECT(xStrCon)to xControl
	r = sqlexec(xControl,tsql,"cur")
	=SQLDISCONNECT(0)
	RETURN r
Endfunc

*... Insertar en Tabla
FUNCTION insertar_a
LPARAMETERS tsql
	xStrCon = "Driver={Microsoft Access Driver (*.mdb)};Dbq="+sys(2003)+"\grupo.mdb;Uid=;Pwd=;"
	STORE SQLSTRINGCONNECT(xStrCon)to xControl
	SQLPREPARE(xControl, tsql)
	r = SQLEXEC(xControl, tsql)
	=SQLDISCONNECT(0)
	RETURN r
ENDFUNC

*... Inserciones repetidasen Tabla
FUNCTION insertar_r_a
LPARAMETERS tsql1,tsql2
	xStrCon = "Driver={Microsoft Access Driver (*.mdb)};Dbq="+sys(2003)+"\grupo.mdb;Uid=;Pwd=;"
	FOR a_x = 1 TO tot_x
		IF a_x = 1 then
			tsql1 = tsql1 + " " +tsql2
		ENDIF
		IF (a_x > 1) and (a_x < tot_x) then
			tsql1 = tsql1 + "," +tsql2
		ENDIF
		IF a_x = tot_x then
			tsql1 = tsql1 + "," +tsql2 + ";"
		endif
	ENDFOR
	STORE SQLSTRINGCONNECT(xStrCon)to xControl
	SQLPREPARE(xControl, tsql1)
	r = SQLEXEC(xControl)
	=SQLDISCONNECT(0)
	RETURN r
ENDFUNC

*... Borrar de la Tabla
FUNCTION borrar_a
LPARAMETERS tsql
	xStrCon = "Driver={Microsoft Access Driver (*.mdb)};Dbq="+sys(2003)+"\grupo.mdb;Uid=;Pwd=;"
	STORE SQLSTRINGCONNECT(xStrCon)to xControl
	r = sqlexec(xControl,tsql,"cur")
	=SQLDISCONNECT(0)
	RETURN r
ENDFUNC


*****************
*...........area de Mensages mandados llamar por _msg
FUNCTION _msg_a
LPARAMETERS tipo
	DO CASE  && Begins loop
	   CASE tipo = 'llene'
	      MESSAGEBOX("Llene los  campos que se le piden",48,"Aviso Sistema")
	   CASE tipo = 'encuentra'
	      MESSAGEBOX("Este Registro ya se Encuentra Guardado",48,"Aviso Sistema")
	   CASE tipo = 'ver'
	      MESSAGEBOX("Verifique Password y Usuario",48,"Aviso Sistema")
	   CASE tipo = 'guarda'
	      MESSAGEBOX("Registro Guardado Satisfactoriamente",64,"Aviso Sistema")   
	   CASE tipo = 'borrar' 
	      r = MESSAGEBOX("Conforme que desea Borrar este Registro",1+256+64,"Aviso Sistema")
	      RETURN r
	   CASE tipo = 'borrado'
	      MESSAGEBOX("Registro Borrado Satisfactoriamente",64,"Aviso Sistema")
	   CASE tipo = 'reemplaza' 
	      r = MESSAGEBOX("Este Registro ya existe, desea remplazarlo",1+256+64,"Aviso Sistema")
	      RETURN r
	   CASE tipo = 'error'
	      MESSAGEBOX("Error de Programa",16,"Aviso Programador")
	   OTHERWISE
	      MESSAGEBOX(tipo,"Aviso Programador")
	ENDCASE  && Ends loop
	RETURN
ENDFUNC

FUNCTION tonos
LPARAMETERS tonito, tipo
*!*	tipo = 1  aumenta tono
*!*	tipo = -1 reduce tono
*!*	tipo = 3 cambia de C a Do
*!*	SET STEP ON 
	r1 = 0
	lenguaje=0
	SELECT lstonos 
	GO top
	LOCATE FOR ALLTRIM(lstonos.tono) = tonito 
	DO WHILE FOUND()
		r1 = lstonos.id
		lenguaje = 1
		continue
	ENDDO
	SELECT lstonos 
	GO top
	LOCATE FOR ALLTRIM(lstonos.ingles) = tonito 
	DO WHILE FOUND()
		r1 = lstonos.id
		lenguaje = 2
		continue
	ENDDO
	IF r1 = 0 OR lenguaje = 0
		MESSAGEBOX('-'+tonito+'-'+ALLTRIM(STR(lenguaje)))
		return
	endif
	IF tipo = 1 &&& sube de tono
		IF (r1 >= 1 AND r1< 12)	OR (r1 >= 13 AND r1< 23)
			IF lenguaje = 2
				SELECT lstonos 
				GO top
				LOCATE FOR (lstonos.id) = ((r1+1))
				if FOUND()
					f = lstonos.ingles
				endif
*!*					tsql = "Select * from tonos where id = "+ ALLTRIM(STR(r1+1))
*!*					consulta_a(tsql)
*!*					f = cur.ingles
			ELSE
				SELECT lstonos 
				GO top
				LOCATE FOR (lstonos.id) = ((r1+1))
				if FOUND()
					f = lstonos.tono
				endif
*!*					tsql = "Select * from tonos where id = "+ ALLTRIM(STR(r1+1))
*!*					consulta_a(tsql)
*!*					f = cur.tono
			endif
		ENDIF
		IF r1 = 12 
			IF lenguaje = 2
				f = 'C'
			ELSE
				f = 'Do'
			endif
		ENDIF
		IF r1 = 23
			IF lenguaje = 2
				f = 'Cm'
			ELSE
				f = 'Dom'
			endif
		endif
	ENDIF
	IF tipo = -1
	 	IF (r1 > 1 AND r1=< 12)	OR (r1 > 13 AND r1 <= 23)
			IF lenguaje = 2
				SELECT lstonos 
				GO top
				LOCATE FOR (lstonos.id) = ((r1-1))
				if FOUND()
					f = lstonos.ingles
				endif
*!*					tsql = "Select * from tonos where id = "+ ALLTRIM(STR(r1-1))
*!*					consulta_a(tsql)
*!*					f = cur.ingles
			ELSE
				SELECT lstonos 
				GO top
				LOCATE FOR (lstonos.id) = ((r1-1))
				if FOUND()
					f = lstonos.tono
				endif
*!*					tsql = "Select * from tonos where id = "+ ALLTRIM(STR(r1-1))
*!*					consulta_a(tsql)
*!*					f = cur.tono
			endif
		ENDIF
		IF r1 = 1 
			IF lenguaje = 2
				f = 'B'
			ELSE
				f = 'Si'
			endif
		ENDIF
		IF r1 = 13
			IF lenguaje = 2
				f = 'Bm'
			ELSE
				f = 'Sim'
			endif
		endif
	ENDIF
	IF tipo = 3
		IF lenguaje = 1
			SELECT lstonos 
			GO top
			LOCATE FOR (lstonos.id) = ((r1))
			if FOUND()
				f = lstonos.ingles
			endif
*!*				tsql = "Select * from tonos where id = "+ ALLTRIM(STR(r1))
*!*				consulta_a(tsql)
*!*				f = cur.ingles
		ENDIF
		IF lenguaje = 2
			SELECT lstonos 
			GO top
			LOCATE FOR (lstonos.id) = ((r1))
			if FOUND()
				f = lstonos.tono
			endif
*!*				tsql = "Select * from tonos where id = "+ ALLTRIM(STR(r1))
*!*				consulta_a(tsql)
*!*				f = cur.tono
		ENDIF
		IF lenguaje <1 OR lenguaje > 3
			MESSAGEBOX(ALLTRIM(STR(r1)))
		ENDIF
		
	endif
RETURN f
ENDFUNC

PROCEDURE barra_progreso_total
PARAMETERS tabla, uno, tot
	lnPorc = MAX(MIN(uno/tot*100,100),0)
	WAIT WINDOW NOWAIT ;
	'Proceso: '+ tabla + ' >> ' +ALLTRIM(STR(uno)) + ' de '+ALLTRIM(STR(tot))+ ' ' + ;
	REPLICATE("|", lnPorc) + REPLICATE(".", 100-lnPorc) + STR((lnPorc),7,4) + "%"
RETURN

