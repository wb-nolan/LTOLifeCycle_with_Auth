"""Add rank columns to LTOLifeCycle

Revision ID: b89cd3fb0283
Revises: 
Create Date: 2024-11-07 21:37:17.342501

"""
from alembic import op
import sqlalchemy as sa
from sqlalchemy.dialects import mysql

# revision identifiers, used by Alembic.
revision = 'b89cd3fb0283'
down_revision = None
branch_labels = None
depends_on = None


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###

    op.add_column('lto_lifecycle', sa.Column('rank_status', sa.Integer(), nullable=True))
    op.add_column('lto_lifecycle', sa.Column('rank_verify', sa.Integer(), nullable=True))
    op.add_column('lto_lifecycle', sa.Column('rank_priority', sa.Integer(), nullable=True))
    op.add_column('lto_lifecycle', sa.Column('rank_md5_comp', sa.Integer(), nullable=True))
    op.add_column('lto_lifecycle', sa.Column('rank_character_check', sa.Integer(), nullable=True))



def upgrade():
  
    op.drop_column('lto_lifecycle', 'rank_character_check')
    op.drop_column('lto_lifecycle', 'rank_md5_comp')
    op.drop_column('lto_lifecycle', 'rank_priority')
    op.drop_column('lto_lifecycle', 'rank_verify')
    op.drop_column('lto_lifecycle', 'rank_status')

   