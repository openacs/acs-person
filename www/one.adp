<master>
<property name="title">@page_title@ @person.pretty_name@</property>
<property name="context_bar">@context_bar@</property>

<h3>@page_title@</h3>
<table width="100%">
  <tr>
    <td valign="top" width="45%">
    <table>

    <tr><th valign=top align=right>First Name</th>
    <td> @person.given_name@ </td></tr>
    
    <tr><th valign=top align=right>Middle Name</th>
    <td> @person.middle_name@ </td></tr>
    
    <tr><th valign=top align=right>Family Name</th>
    <td> @person.family_name@ </td></tr>
    
    <if @person.preferred_given_name@ not nil>
    <tr><th valign=top align=right>Preferred Name</th>
    <td> @person.preferred_given_name@ </td></tr>
    </if>
	 
    <if @person.formatted_name@ not nil>
    <tr><th valign=top align=right>Formatted Name</th>
    <td> @person.formatted_name@ </td></tr>
    </if>

    <if @person.write_p@ eq 1>
    <tr><td colspan="2" align="right">
    <a href="add-edit.tcl?acs_person_id=@person.acs_person_id@">edit info</a>
    </td></tr>
    </if>
    </table>
   </td>
  </tr>
</table>


