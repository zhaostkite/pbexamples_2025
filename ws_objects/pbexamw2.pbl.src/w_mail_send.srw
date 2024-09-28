﻿$PBExportHeader$w_mail_send.srw
$PBExportComments$Window used to send MSMail
forward
global type w_mail_send from w_center
end type
type cb_help from commandbutton within w_mail_send
end type
type mle_msg from multilineedit within w_mail_send
end type
type cbx_receipt_requested from checkbox within w_mail_send
end type
type rb_employees from radiobutton within w_mail_send
end type
type rb_departments from radiobutton within w_mail_send
end type
type rb_customers from radiobutton within w_mail_send
end type
type st_status_bar from statictext within w_mail_send
end type
type mle_subject from multilineedit within w_mail_send
end type
type cbx_file from checkbox within w_mail_send
end type
type cbx_address_live from checkbox within w_mail_send
end type
type cb_send_mail from commandbutton within w_mail_send
end type
type cb_close from commandbutton within w_mail_send
end type
type dw_1 from datawindow within w_mail_send
end type
type gb_body from groupbox within w_mail_send
end type
type gb_5 from groupbox within w_mail_send
end type
type gb_4 from groupbox within w_mail_send
end type
type gb_3 from groupbox within w_mail_send
end type
type gb_subject from groupbox within w_mail_send
end type
type gb_1 from groupbox within w_mail_send
end type
end forward

global type w_mail_send from w_center
integer x = 9
integer width = 2487
integer height = 2004
string title = "MAPI Mail - Send Mail"
long backcolor = 74481808
toolbaralignment toolbaralignment = alignatleft!
cb_help cb_help
mle_msg mle_msg
cbx_receipt_requested cbx_receipt_requested
rb_employees rb_employees
rb_departments rb_departments
rb_customers rb_customers
st_status_bar st_status_bar
mle_subject mle_subject
cbx_file cbx_file
cbx_address_live cbx_address_live
cb_send_mail cb_send_mail
cb_close cb_close
dw_1 dw_1
gb_body gb_body
gb_5 gb_5
gb_4 gb_4
gb_3 gb_3
gb_subject gb_subject
gb_1 gb_1
end type
global w_mail_send w_mail_send

type variables
string	is_dwSyntax, is_dataSyntax
end variables

forward prototypes
public subroutine wf_logoff_mail (ref mailsession ams_mses, string as_attach_name)
end prototypes

public subroutine wf_logoff_mail (ref mailsession ams_mses, string as_attach_name);string 	ls_ret	
mailreturncode mRet

/*****************************************************************
	Log off from the mail system
 *****************************************************************/
mRet = ams_mSes.mailLogoff ( )
ls_ret = f_mail_error_to_string ( mRet, 'Logoff:', FALSE )
st_status_bar.text = ' Logoff: ' + ls_ret

If mRet <> mailReturnSuccess! Then
	MessageBox ("Mail Logoff", 'Return Code <> mailReturnSuccess!' )
	return
End If

/*****************************************************************
	Finally, destroy the mail session object created earlier.
	Also, delete the temporary attachment file.
 *****************************************************************/
destroy ams_mses


FileDelete ( as_attach_name )
end subroutine

event open;call super::open;// Open script

dw_1.SetTransObject (sqlca)

dw_1.Retrieve ( )

end event

event close;call super::close;// Close script

//w_main.Show ( )

end event

on w_mail_send.create
int iCurrent
call super::create
this.cb_help=create cb_help
this.mle_msg=create mle_msg
this.cbx_receipt_requested=create cbx_receipt_requested
this.rb_employees=create rb_employees
this.rb_departments=create rb_departments
this.rb_customers=create rb_customers
this.st_status_bar=create st_status_bar
this.mle_subject=create mle_subject
this.cbx_file=create cbx_file
this.cbx_address_live=create cbx_address_live
this.cb_send_mail=create cb_send_mail
this.cb_close=create cb_close
this.dw_1=create dw_1
this.gb_body=create gb_body
this.gb_5=create gb_5
this.gb_4=create gb_4
this.gb_3=create gb_3
this.gb_subject=create gb_subject
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_help
this.Control[iCurrent+2]=this.mle_msg
this.Control[iCurrent+3]=this.cbx_receipt_requested
this.Control[iCurrent+4]=this.rb_employees
this.Control[iCurrent+5]=this.rb_departments
this.Control[iCurrent+6]=this.rb_customers
this.Control[iCurrent+7]=this.st_status_bar
this.Control[iCurrent+8]=this.mle_subject
this.Control[iCurrent+9]=this.cbx_file
this.Control[iCurrent+10]=this.cbx_address_live
this.Control[iCurrent+11]=this.cb_send_mail
this.Control[iCurrent+12]=this.cb_close
this.Control[iCurrent+13]=this.dw_1
this.Control[iCurrent+14]=this.gb_body
this.Control[iCurrent+15]=this.gb_5
this.Control[iCurrent+16]=this.gb_4
this.Control[iCurrent+17]=this.gb_3
this.Control[iCurrent+18]=this.gb_subject
this.Control[iCurrent+19]=this.gb_1
end on

on w_mail_send.destroy
call super::destroy
destroy(this.cb_help)
destroy(this.mle_msg)
destroy(this.cbx_receipt_requested)
destroy(this.rb_employees)
destroy(this.rb_departments)
destroy(this.rb_customers)
destroy(this.st_status_bar)
destroy(this.mle_subject)
destroy(this.cbx_file)
destroy(this.cbx_address_live)
destroy(this.cb_send_mail)
destroy(this.cb_close)
destroy(this.dw_1)
destroy(this.gb_body)
destroy(this.gb_5)
destroy(this.gb_4)
destroy(this.gb_3)
destroy(this.gb_subject)
destroy(this.gb_1)
end on

type cb_help from commandbutton within w_mail_send
integer x = 1522
integer y = 1716
integer width = 338
integer height = 100
integer taborder = 80
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Help"
end type

on clicked;f_open_help(parent.ClassName( ))
end on

type mle_msg from multilineedit within w_mail_send
integer x = 96
integer y = 444
integer width = 2281
integer height = 172
integer taborder = 20
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
boolean vscrollbar = true
end type

type cbx_receipt_requested from checkbox within w_mail_send
integer x = 1381
integer y = 80
integer width = 759
integer height = 72
integer taborder = 120
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
string text = "Request Receipt"
end type

type rb_employees from radiobutton within w_mail_send
integer x = 882
integer y = 716
integer width = 338
integer height = 76
integer taborder = 50
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
string text = "&Employees"
end type

on clicked;dw_1.DataObject = "d_empl_basic_data"
dw_1.settransobject(sqlca)
dw_1.retrieve()
end on

type rb_departments from radiobutton within w_mail_send
integer x = 480
integer y = 716
integer width = 375
integer height = 76
integer taborder = 40
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
string text = "&Departments"
end type

on clicked;dw_1.DataObject = "d_dept"
dw_1.settransobject(sqlca)
dw_1.retrieve()
end on

type rb_customers from radiobutton within w_mail_send
integer x = 96
integer y = 716
integer width = 338
integer height = 72
integer taborder = 30
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
string text = "&Customers"
boolean checked = true
end type

on clicked;
dw_1.DataObject = "d_retrieve_cust"
dw_1.settransobject(sqlca)
dw_1.retrieve()
end on

type st_status_bar from statictext within w_mail_send
integer x = 128
integer y = 1604
integer width = 2194
integer height = 72
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
boolean enabled = false
boolean focusrectangle = false
end type

type mle_subject from multilineedit within w_mail_send
integer x = 91
integer y = 280
integer width = 2281
integer height = 92
integer taborder = 10
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
boolean autovscroll = true
end type

type cbx_file from checkbox within w_mail_send
integer x = 96
integer y = 120
integer width = 809
integer height = 72
integer taborder = 110
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
string text = "&Read recipient names from a file"
end type

type cbx_address_live from checkbox within w_mail_send
integer x = 96
integer y = 60
integer width = 1157
integer height = 72
integer taborder = 100
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
string text = "&Select recipients from Post Office address book"
boolean checked = true
end type

type cb_send_mail from commandbutton within w_mail_send
integer x = 594
integer y = 1716
integer width = 338
integer height = 100
integer taborder = 70
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Send &Mail"
end type

event clicked;// Clicked script for cb_send_mail

/*******************************************************************
	Mail the definition and current contents of a DataWindow using
	MAPI facilities.
	1. Get the PSR file saved from the datawindow chosen
	2. Create a mail session object and log onto the mail system
	3. Read addressees from a file (ASCII, one per line), If desired
	4. Get address names from box If needed
	5. Resolve all names
	6. send mail, with attached .dwx file
	7. Log off from mail system
	8. Destroy the mail session object
	9. Delete the attachment (saved) file
 *******************************************************************/

mailSession				mSes
mailReturnCode			mRet
mailMessage			mMsg
mailFileDescription		mAttach
string					ls_ret, ls_syntax, ls_name, ls_open_pathname, ls_filename
string					ls_attach_name='DataWndw.psr'
int						li_index, li_nret, li_nrecipients, li_nfile
boolean 				lb_noerrors


/*****************************************************************
	Make sure user has chosen at least one addressing option.
 *****************************************************************/
If NOT cbx_file.checked AND NOT cbx_address_live.checked Then
	MessageBox ("send Mail", &
					"Please select at least 1 address option", &
					Exclamation!)
	wf_logoff_mail(mSes, ls_attach_name)
	return
End If


/*****************************************************************
	Obtain the syntax of the DataWindow definition and contents,
	and write it in a ".dwx" transport file (in ASCII)
 *****************************************************************/

dw_1.saveas(ls_attach_name,PSReport!,True)

//This is another way of sending the datawindow contents. ie breaking the 
//syntax and data up and mailing them together. 
//The PSR file is the prefered method now.
//is_dwsyntax = dw_1.Describe ( 'datawindow.syntax' )
//is_datasyntax = dw_1.Describe ( 'datawindow.syntax.data' )
//ls_syntax = is_dwsyntax + '~r' + is_datasyntax
//
//li_nfile = FileOpen  ( ls_attach_name, StreamMode!, Write!, LockReadWrite!, Replace! )
//If li_nfile < 0 Then
//	MessageBox ( "send Mail", &
//				"Unable to open file to save DataWindow attachment", &
//				 StopSign! )
//	wf_logoff_mail(mSes, ls_attach_name)
//	return
//End If
//li_nret = FileWrite ( li_nfile, ls_syntax )
//FileClose ( li_nfile )

/*****************************************************************
	Establish an instance of the Mail Session object, and log on
 *****************************************************************/
mSes = create mailSession

/*****************************************************************
	Note: If the mail-system user ID and password are known,
			they could be hard-coded here, as shown in the
			commented-out statement that follows.  If user ID and
			password are not supplied, it is assumed that they
			are stored in MSMAIL.INI
 *****************************************************************/
mRet = mSes.mailLogon ( mailNewSession! )
ls_ret = f_mail_error_to_string ( mRet, 'Logon:', FALSE )
st_status_bar.text = ' Logon: ' + ls_ret
If mRet <> mailReturnSuccess! Then
	MessageBox ("Mail Logon", 'Return Code <> mailReturnSuccess!' )
	wf_logoff_mail(mSes, ls_attach_name)
	return
End If

SetPointer(HourGlass!)

/*****************************************************************
	Copy user's subject to the mail message.
	Set return receipt flag If needed.
	Build an Attachment structure, and assign it to the mail message.
 *****************************************************************/
mMsg.Subject	= mle_subject.text

If cbx_receipt_requested.checked Then
	mMsg.ReceiptRequested = true
End If

mMsg.notetext = mle_msg.text +"~n~r "

mAttach.FileType = mailAttach!
mAttach.PathName = ls_attach_name
mAttach.FileName = ls_attach_name
// Note: In MS Mail version 3.0b, Position=-1 puts attachment at
//  the beginning of the message.
// This will place the attachment at the End of the text of the message
mAttach.Position = len(mMsg.notetext) - 1		
mMsg.AttachmentFile[1] = mAttach

/*****************************************************************
	If user requested "addresses-from-a-file," open that file and
	read the address list.
 *****************************************************************/
If cbx_file.checked Then
	li_nret = GetFileOpenName ("Address", ls_open_pathname, &
								ls_filename,"adr", &
		"Address Text Files (*.adr),*.adr,All Files (*.*),*.*")
	If li_nret < 1 Then return
	li_nfile = FileOpen ( ls_open_pathname )
	If li_nfile < 0 Then
		MessageBox ( "send Mail", "Unable to open file " &
						+ ls_open_pathname, StopSign! )
		wf_logoff_mail(mSes, ls_attach_name)
		return
	End If

	li_nrecipients = 0
	do while FileRead ( li_nfile, ls_name ) > 0
		li_nrecipients = li_nrecipients + 1
		mMsg.Recipient[li_nrecipients].Name = ls_name
	loop
	FileClose ( li_nfile )
End If



/*****************************************************************
	If user requested "address-from-Post-Office," call the
	mail system's Address function
 *****************************************************************/
If cbx_address_live.checked Then
	mRet = mSes.mailAddress ( mMsg )
	If mRet = mailReturnUserAbort! Then 
		st_status_bar.text = "User Canceled send Mail"
		wf_logoff_mail(mSes, ls_attach_name)
		Return
	End If
	ls_ret = f_mail_error_to_string ( mRet, 'Address Mail:', FALSE )
	st_status_bar.text = ' Address Mail: ' + ls_ret
End If


/*****************************************************************
	Resolve recipient addresses, which may be only partially
	supplied, to get the complete address for each one.

	Loop in this until the names are all resovled with no
	errors. The message will not be sent If errors are in
	the user name.

	The user can cancel out of resolving names which
	will cancel the entire send mail process
 *****************************************************************/
SetPointer(HourGlass!)

Do 
	lb_noerrors = True
	li_nrecipients = UpperBound( mMsg.Recipient )
	For li_index = 1 To li_nrecipients
		mRet = mSes.mailResolveRecipient(mMsg.Recipient[li_index].Name)
		If mRet <> mailReturnSuccess! Then lb_noerrors = False
		ls_ret = f_mail_error_to_string ( mRet, 'Resolve Recipient:', FALSE )
		st_status_bar.text = ' Resolve Recipient (' + mMsg.Recipient[li_index].Name + '): ' + ls_ret
	Next
	If Not lb_noerrors Then
		Messagebox("Microsoft Mail","Error Resolving Name(s)~n~r"+&
		"The name(s) not underlined are unresolvable.~n~n~rPlease Correct or Cancel"&
		,Exclamation!)
		mRet = mSes.mailAddress(mMsg)
		If mRet = mailReturnUserAbort! Then 
			st_status_bar.text = "User Canceled Send Mail"
			wf_logoff_mail(mSes, ls_attach_name)
			Return
		End If
	End If
Loop Until lb_noerrors

/*****************************************************************
	Now, send the mail message, including the attachment
 *****************************************************************/
If UpperBound ( mMsg.Recipient ) < 1 Then 
	messagebox ("Powerbuilder send","Mail must included at least 1 recipient",Exclamation!)
	wf_logoff_mail(mSes, ls_attach_name)
	return
End If
mRet = mSes.mailsend ( mMsg )
ls_ret = f_mail_error_to_string ( mRet, 'send Mail:', FALSE )
st_status_bar.text = ' send Mail: ' + ls_ret

wf_logoff_mail(mSes, ls_attach_name)

end event

type cb_close from commandbutton within w_mail_send
integer x = 1061
integer y = 1716
integer width = 338
integer height = 100
integer taborder = 90
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Close"
end type

on clicked;// Clicked script for cb_exit

Close (Parent)

end on

type dw_1 from datawindow within w_mail_send
integer x = 50
integer y = 828
integer width = 2354
integer height = 668
integer taborder = 60
string dataobject = "d_retrieve_cust"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_body from groupbox within w_mail_send
integer x = 50
integer y = 384
integer width = 2354
integer height = 264
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
string text = "&Message"
end type

type gb_5 from groupbox within w_mail_send
integer x = 50
integer y = 1544
integer width = 2354
integer height = 156
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
string text = "Status"
end type

type gb_4 from groupbox within w_mail_send
integer x = 1349
integer y = 4
integer width = 1056
integer height = 204
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
string text = "Mail Receipt Requested"
end type

type gb_3 from groupbox within w_mail_send
integer x = 50
integer y = 664
integer width = 2354
integer height = 136
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
string text = "DataWindow to Send"
end type

type gb_subject from groupbox within w_mail_send
integer x = 50
integer y = 220
integer width = 2354
integer height = 164
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
string text = "&Subject"
end type

type gb_1 from groupbox within w_mail_send
integer x = 50
integer y = 4
integer width = 1280
integer height = 204
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
string text = "Address"
end type

