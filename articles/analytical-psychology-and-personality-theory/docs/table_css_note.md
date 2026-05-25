# WordPress Table CSS Note

For article tables, use the site-compatible table structure:

```html
<div class="cc-table-wrap">
<table class="cc-table">
<thead>
<tr>
<th>Column</th>
<th>Column</th>
</tr>
</thead>
<tbody>
<tr>
<td>Value</td>
<td>Value</td>
</tr>
</tbody>
</table>
</div>
```

Avoid `cc-custom-table`. The current compatible table class is `cc-table`.
