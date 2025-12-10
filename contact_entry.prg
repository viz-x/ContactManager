* BANCstar Contact Card Server - Entry Form
* Compatible with xBase/Clipper/FoxPro systems

* Initialize memory variables
PUBLIC M_NAME, M_PHONE
M_NAME = SPACE(30)
M_PHONE = SPACE(20)

* Main entry screen
DO WHILE .T.
  CLEAR
  @ 1,20 SAY "Contact Card Server - Entry"
  @ 2,20 SAY "=============================="
  
  @ 4,5 SAY "Name:"
  @ 4,15 GET M_NAME PICTURE "@!" VALID !EMPTY(M_NAME)
  
  @ 6,5 SAY "Phone:"
  @ 6,15 GET M_PHONE PICTURE "@!" VALID !EMPTY(M_PHONE)
  
  @ 9,15 SAY "[S]ave   [E]xit"
  @ 10,15 GET M_CHOICE PICTURE "!" VALID M_CHOICE $ "SE"
  
  READ
  
  DO CASE
    CASE UPPER(M_CHOICE) = "S"
      DO SAVE_CONTACT
    CASE UPPER(M_CHOICE) = "E"
      EXIT
  ENDCASE
ENDDO

CLEAR
RETURN

* Save contact procedure
PROCEDURE SAVE_CONTACT
  LOCAL V_NAME, V_PHONE, F_HANDLE
  
  * Trim input
  V_NAME = ALLTRIM(M_NAME)
  V_PHONE = ALLTRIM(M_PHONE)
  
  * Validate
  IF EMPTY(V_NAME) .OR. EMPTY(V_PHONE)
    @ 12,15 SAY "Error: Both fields required!"
    WAIT
    RETURN
  ENDIF
  
  * Write to file using low-level file functions
  F_HANDLE = FCREATE("contact.txt")
  
  IF F_HANDLE < 0
    @ 12,15 SAY "Error: Cannot create file!"
    WAIT
    RETURN
  ENDIF
  
  * Write name line
  FWRITE(F_HANDLE, V_NAME + CHR(13) + CHR(10))
  * Write phone line
  FWRITE(F_HANDLE, V_PHONE + CHR(13) + CHR(10))
  
  FCLOSE(F_HANDLE)
  
  * Success message
  @ 12,15 SAY "Contact saved to contact.txt"
  WAIT
  
  * Clear for next entry
  M_NAME = SPACE(30)
  M_PHONE = SPACE(20)
  
RETURN
