<master>
<property name="title">@title@</property>
<property name="context_bar">@context_bar@</property>


<h4>@title@</h4>

<if admin_p ne 0>
 <div align="right">
  <a href="admin/">Admin</a>
 </div>
</if>


<if @persons:rowcount@ gt 0>

<table border="0" cellspacing="1" cellpadding="5" width="100%">
 <tr bgcolor="#ffffff">
  <td colspan="7">
    <center>
    <multiple name="first_letter">
      <if @first_letter.letter@ ne @starts_with@>
      <a href=".?starts_with=@first_letter.letter@">@first_letter.letter@</a>
      </if>
      <else>
      <b>@first_letter.letter@</b>
      </else>
    </multiple>
    <if @starts_with@ eq "all">
      <b>All</b>
    </if>
    <else>
      <a href=".?starts_with=all"><b>All</b></a>
    </else>
    <if @starts_with@ eq "other">
      <b>Other</b>
    </if>
    <else>
      <a href=".?starts_with=other"><b>Other</b></a>
    </else>
    </center>
    <br>

    <if @starts_with@ ne "">
    <div style="background-color: #eeeeee; width:100%;">
    <font size="+1"><b>@starts_with@ :</b></font>
    </div>
    </if>

    <if @search_p@ ne 0 and @search_string@ ne "">
    <div style="background-color: #eeeeee; width:100%;">
    <font size="+1"><b>Search results :</b></font>
    </div>
    </if>
  </td>
 </tr>
 <tr bgcolor="#cccccc">
  <th nowrap align="left"><a href=".?sort=lname&search_p=@search_p@&search_string=@search_string@&starts_with=@starts_with@">Last Name</a></th>
  <th nowrap align="left"><a href=".?sort=fname&search_p=@search_p@&search_string=@search_string@&starts_with=@starts_with@">First Name</a></th>
  <th>&nbsp;</th>
  <th>&nbsp;</th>
 </tr>
 <multiple name=persons>

 <if @persons.rownum@  odd>
  <tr bgcolor=#cccccc>
 </if>
 <else>
  <tr bgcolor=#ffffff>
 </else>

  <td><a href="one?acs_person_id=@persons.acs_person_id@">@persons.family_name@</a></td>

  <td>@persons.given_name@</td>

  <td>
  <if @persons.write_p@ eq "t"><a href="add-edit?acs_person_id=@persons.acs_person_id@">Edit</a></if>&nbsp;
  </td>

  <td>
  <if @persons.delete_p@ eq "t"><a href="delete?acs_person_id=@persons.acs_person_id@">Delete</a></if>&nbsp;
  </td>
</tr>
</multiple>
</table>

<br><br>
@pagination_link@

</if>
<else>
  <table border=0 width=100%>
    <tr bgcolor=#eeeeee>
      <td align=center><br>There are no people<br>&nbsp;</td>
    </tr>
  </table>
</else>

<if @acs_persons_create_p@ ne 0>
  <br>
  <div align="center">
  <a href="add-edit">New Person</a>
  </div>
</if>

