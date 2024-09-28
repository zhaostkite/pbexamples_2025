﻿$PBExportHeader$w_ancestor_one_dw.srw
$PBExportComments$Ancestor window with one DataWindow control.  Operations for retrieval, updating, deleting, inserting the DataWindow.
forward
global type w_ancestor_one_dw from w_center
end type
type cb_close from commandbutton within w_ancestor_one_dw
end type
type cb_delete from commandbutton within w_ancestor_one_dw
end type
type cb_insert from commandbutton within w_ancestor_one_dw
end type
type cb_update from commandbutton within w_ancestor_one_dw
end type
type cb_retrieve from commandbutton within w_ancestor_one_dw
end type
type dw_1 from datawindow within w_ancestor_one_dw
end type
end forward

global type w_ancestor_one_dw from w_center
integer x = 210
integer y = 336
integer width = 2505
integer height = 1252
string title = "w_ancestor_one_dw"
long backcolor = 74481808
toolbaralignment toolbaralignment = alignatleft!
event ue_close pbm_custom01
event ue_retrieve pbm_custom02
event ue_update pbm_custom03
event ue_insert_row pbm_custom04
event ue_delete_row pbm_custom05
cb_close cb_close
cb_delete cb_delete
cb_insert cb_insert
cb_update cb_update
cb_retrieve cb_retrieve
dw_1 dw_1
end type
global w_ancestor_one_dw w_ancestor_one_dw

type variables
// Class object used for business rules
u_business_object   iuo_business_object

// Determine if data has been changed
boolean   ib_changed

end variables

on ue_close;//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Close the window
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

close (this)
end on

event ue_retrieve;Integer		li_RC

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Call business object function to retrieve the DataWindow
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

li_RC = iuo_business_object.uf_retrieve()


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Enable/Disable Delete command button, depending on success of the retrieve,
// also update instance variable showing that data has not been changed
// yet (we have just retrieved)
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
If li_RC < 0 Then
	cb_delete.enabled = False
Else
	ib_changed = False
	cb_update.enabled = False
	If li_RC > 0 Then cb_delete.enabled = True
End If

Return li_RC

end event

event ue_update;Integer	li_RC

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Call business object function to update the DataWindow
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

li_RC = iuo_business_object.uf_update()
If li_RC = 1 Then
	ib_changed = False
	cb_update.enabled = False
End If

Return li_RC

end event

event ue_insert_row;Integer	li_RC
Long	ll_cur_row


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Obtain the current row from the DataWindow
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
ll_cur_row = dw_1.GetRow()


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Call business object function to insert a row into the DataWindow
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
If ll_cur_row >= 0 Then
	li_RC = iuo_business_object.uf_insert_row (ll_cur_row)
	If li_RC > 0 Then
		cb_delete.enabled = True
	End If
End If

Return li_RC

end event

event ue_delete_row;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Call business object function to delete the current row from the DataWindow
//
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

dwitemstatus	le_status
Long					ll_cur_row
Integer				li_RC


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Obtain the current row number
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
ll_cur_row = dw_1.GetRow()

If ll_cur_row > 0 Then
	
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// Obtain the row status of the current row
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	le_status = dw_1.GetItemStatus (ll_cur_row, 0, primary!)	

	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// Call user object function to delete the row
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	li_RC = iuo_business_object.uf_delete_row (0)

	If li_RC = 1 Then
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// Disable Delete command button if there are no more rows in the DataWindow
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////		
		If dw_1.RowCount() = 0 Then
			cb_delete.enabled = False
		End If

		///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// Update the instance variable indicating that data in the DataWindow
		// has changed (if the row was not a new row)
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////		
		If le_status <> new! And le_status <> newmodified! Then
			ib_changed = True
			cb_update.enabled = True
		End If
	End If
End If

Return li_RC

end event

on w_ancestor_one_dw.create
int iCurrent
call super::create
this.cb_close=create cb_close
this.cb_delete=create cb_delete
this.cb_insert=create cb_insert
this.cb_update=create cb_update
this.cb_retrieve=create cb_retrieve
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_close
this.Control[iCurrent+2]=this.cb_delete
this.Control[iCurrent+3]=this.cb_insert
this.Control[iCurrent+4]=this.cb_update
this.Control[iCurrent+5]=this.cb_retrieve
this.Control[iCurrent+6]=this.dw_1
end on

on w_ancestor_one_dw.destroy
call super::destroy
destroy(this.cb_close)
destroy(this.cb_delete)
destroy(this.cb_insert)
destroy(this.cb_update)
destroy(this.cb_retrieve)
destroy(this.dw_1)
end on

event open;call super::open;//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Set transaction object for the DataWindow.
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
dw_1.SetTransObject (sqlca)


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Create the business class object
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
dw_1.TriggerEvent ("ue_create_business_object")


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Let the business object know which DataWindow to use
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
iuo_business_object.uf_init (dw_1)


end event

event close;call super::close;//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Destroy the business class object
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

destroy iuo_business_object
end event

on closequery;//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// If data in the DataWindow has been changed but not saved, prompt user to save it.
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

int	li_rc


if ib_changed then
	li_rc = MessageBox ("Employee data has changed", "Save changes before closing?", question!, yesnocancel!)	
	
	// Yes
	if li_rc = 1 then
		this.TriggerEvent ("ue_update")
		if ib_changed then
			message.ReturnValue = 1
		end if
	else
		// Cancel
		if li_rc = 3 then
			message.ReturnValue = 1
		end if
	end if
end if
end on

type cb_close from commandbutton within w_ancestor_one_dw
integer x = 2089
integer y = 496
integer width = 352
integer height = 100
integer taborder = 60
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Close"
end type

on clicked;parent.TriggerEvent ("ue_close")
end on

type cb_delete from commandbutton within w_ancestor_one_dw
integer x = 2089
integer y = 380
integer width = 352
integer height = 100
integer taborder = 50
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "&Delete Row"
end type

on clicked;parent.TriggerEvent ("ue_delete_row")
end on

type cb_insert from commandbutton within w_ancestor_one_dw
integer x = 2089
integer y = 264
integer width = 352
integer height = 100
integer taborder = 40
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Insert Row"
end type

on clicked;parent.TriggerEvent ("ue_insert_row")
end on

type cb_update from commandbutton within w_ancestor_one_dw
integer x = 2089
integer y = 148
integer width = 352
integer height = 100
integer taborder = 30
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "&Update"
end type

on clicked;parent.TriggerEvent ("ue_update")
end on

type cb_retrieve from commandbutton within w_ancestor_one_dw
integer x = 2089
integer y = 32
integer width = 352
integer height = 100
integer taborder = 20
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Retrieve"
end type

on clicked;parent.TriggerEvent ("ue_retrieve")
end on

type dw_1 from datawindow within w_ancestor_one_dw
event ue_create_business_object pbm_custom01
integer x = 41
integer y = 36
integer width = 2002
integer height = 1080
integer taborder = 10
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

on ue_create_business_object;//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Create the ancestor business object.  In descendant windows, this script can be overriden
// to create a specific descendant business object.
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

iuo_business_object = create u_business_object
end on

on editchanged;//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Update instance variable indicating that data in the DataWindow has changed.
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

ib_changed = true
cb_update.enabled = true
end on

on itemchanged;//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Update instance variable indicating that data in the DataWindow has changed.
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

ib_changed = true
cb_update.enabled = true
end on
