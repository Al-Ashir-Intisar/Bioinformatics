open(GB, 'sequence.gb');
@record=<GB>;
$record=join('', @record);
print $record;