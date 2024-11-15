def convert_zero_datetime(value):
    if value == '0000-00-00 00:00:00':
        return None
    return value


def convert_dates(table_instance):
    # List of attributes to convert
    attributes_to_convert = [
        'date_added',
        'date_modified',
        'date_archived',
        'date_deleted',
        'date_started',
        'date_completed',
        'process_start',
    ]
    for attr in attributes_to_convert:
        if hasattr(table_instance, attr):  # Check if the attribute exists
            # Get the value of the attribute
            value = getattr(table_instance, attr)
            # Check the value before converting
            if value == '0000-00-00 00:00:00':
                # Set to None for the specific placeholder
                setattr(table_instance, attr, None)
            else:
                setattr(table_instance, attr, convert_zero_datetime(value))
