"""Aggiunte colonne risoluzione_problema e codice_interno

Revision ID: ed919ba39077
Revises: 
Create Date: 2024-11-29 10:07:53.833628

"""
from alembic import op
import sqlalchemy as sa
from sqlalchemy.dialects import postgresql

# revision identifiers, used by Alembic.
revision = 'ed919ba39077'
down_revision = None
branch_labels = None
depends_on = None


def upgrade():
    # Modifica la tabella 'interventi'
    with op.batch_alter_table('interventi', schema=None) as batch_op:
        batch_op.alter_column('priorità',
               existing_type=sa.VARCHAR(length=50),
               nullable=False)
        batch_op.alter_column('tipo_intervento',
               existing_type=sa.VARCHAR(length=50),
               type_=sa.String(length=100),
               nullable=False)
        batch_op.alter_column('descrizione',
               existing_type=sa.TEXT(),
               nullable=False)
        batch_op.alter_column('nome_manutentore',
               existing_type=sa.VARCHAR(length=255),
               type_=sa.String(length=100),
               existing_nullable=True)
        batch_op.drop_constraint('interventi_manutentore_id_fkey', type_='foreignkey')
        batch_op.drop_column('manutentore_id')
        batch_op.drop_column('data_richiesta')

    # Modifica la tabella 'manutentori'
    with op.batch_alter_table('manutentori', schema=None) as batch_op:
        batch_op.add_column(sa.Column('cognome', sa.String(length=50), nullable=True))
        batch_op.execute("UPDATE manutentori SET cognome = ''")  # Imposta un valore di default
        batch_op.alter_column('cognome', nullable=False)  # Rendi la colonna NOT NULL
        batch_op.alter_column('nome',
               existing_type=sa.VARCHAR(length=100),
               type_=sa.String(length=50),
               existing_nullable=False)
        batch_op.drop_column('email')

    # Modifica la tabella 'rapporti_intervento'
    with op.batch_alter_table('rapporti_intervento', schema=None) as batch_op:
        batch_op.alter_column('intervento_id',
               existing_type=sa.INTEGER(),
               nullable=False)
        batch_op.alter_column('macchina',
               existing_type=sa.VARCHAR(length=100),
               nullable=False)
        batch_op.drop_constraint('rapporti_intervento_manutentore_id_fkey', type_='foreignkey')
        batch_op.drop_column('manutentore_id')


def downgrade():
    # Ripristina la tabella 'rapporti_intervento'
    with op.batch_alter_table('rapporti_intervento', schema=None) as batch_op:
        batch_op.add_column(sa.Column('manutentore_id', sa.INTEGER(), autoincrement=False, nullable=True))
        batch_op.create_foreign_key('rapporti_intervento_manutentore_id_fkey', 'manutentori', ['manutentore_id'], ['id'])
        batch_op.alter_column('macchina',
               existing_type=sa.VARCHAR(length=100),
               nullable=True)
        batch_op.alter_column('intervento_id',
               existing_type=sa.INTEGER(),
               nullable=True)

    # Ripristina la tabella 'manutentori'
    with op.batch_alter_table('manutentori', schema=None) as batch_op:
        batch_op.add_column(sa.Column('email', sa.VARCHAR(length=100), autoincrement=False, nullable=True))
        batch_op.alter_column('nome',
               existing_type=sa.String(length=50),
               type_=sa.VARCHAR(length=100),
               existing_nullable=False)
        batch_op.drop_column('cognome')

    # Ripristina la tabella 'interventi'
    with op.batch_alter_table('interventi', schema=None) as batch_op:
        batch_op.add_column(sa.Column('data_richiesta', postgresql.TIMESTAMP(), server_default=sa.text('CURRENT_TIMESTAMP'), autoincrement=False, nullable=True))
        batch_op.add_column(sa.Column('manutentore_id', sa.INTEGER(), autoincrement=False, nullable=True))
        batch_op.create_foreign_key('interventi_manutentore_id_fkey', 'manutentori', ['manutentore_id'], ['id'])
        batch_op.alter_column('nome_manutentore',
               existing_type=sa.String(length=100),
               type_=sa.VARCHAR(length=255),
               existing_nullable=True)
        batch_op.alter_column('descrizione',
               existing_type=sa.TEXT(),
               nullable=True)
        batch_op.alter_column('tipo_intervento',
               existing_type=sa.String(length=100),
               type_=sa.VARCHAR(length=50),
               nullable=True)
        batch_op.alter_column('priorità',
               existing_type=sa.VARCHAR(length=50),
               nullable=True)

    # ### end Alembic commands ###
