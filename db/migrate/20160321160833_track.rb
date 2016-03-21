
<% @tracks.each do |track| %>
  <div class="track">
    <h3><a href="/tracks/<%= track.id %>">(Posted by: <%= track.author %>)</a></h3>
    <p> Posted at: <%= track.created_at %></p>
    <p>
    <% if track.url.length != 0 %>
      <a href="<%= message.url %>">To the track!</a>
    <% end %>      
    </p>
  </div>
<% end %>