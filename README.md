# Random Tiler
Want to randomly tile a quad, with uniformity or non-uniformity?
To use, you can edit the vertices used to create a quad stored in the wall variable.
```lua
local wall = quad.new(
    {x = 10, y = 10},
    {x = 110, y = 10},
    {x = 10, y = 110},
    {x = 110, y = 110}
)
```

Using default variables with the vertices as shown above, you receive the following results:<br>
<table>
  <th>
    <div>
      <b>Uniform:<b>
      <br>
      <img src="https://raw.githubusercontent.com/Thomasssb1/random-tiler/main/wall.png"/>
    </div>
  </th>
  <th>
    <div>
      <b>Non-Uniform:<b>
      <br>
      <img src="https://raw.githubusercontent.com/Thomasssb1/random-tiler/main/wall2.png"/>
    </div>
  </th>
</div>
