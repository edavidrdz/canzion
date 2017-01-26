*clear all
set defa to sys(2003)
SET SYSMENU off
SET ECHO OFF
*!*	DO checkocx.prg WITH 'check'
set talk off
set century on
SET CLOCK off
*set date brit
set delete on
set exclusive off
set safety off
set refresh to 5
set reprocess to automatic
set multilock on
SET MEMOWIDTH TO 400
SET LOCK OFF
ON SHUTDOWN quit
SET PROCEDURE TO acces ADDITIVE
PUBLIC lis 

_screen.windowstate = 0
_screen.Visible = .f.
*_screen.backcolor=rgb(0, 0, 128)
_screen.closable=.f.
_screen.maxbutton=.f.
_screen.minbutton=.f.
_screen.caption="Yield"

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

do form canzion

read event

clear all
set sysmenu to 
*!*	DO checkocx.prg WITH 'UnRegALL'