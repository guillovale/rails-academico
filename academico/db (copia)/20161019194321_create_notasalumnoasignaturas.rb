class CreateNotasalumnoasignaturas < ActiveRecord::Migration[5.0]
  def change
    create_table :notasalumnoasignaturas do |t|
      t.integer :idnaa
      t.string :CIInfPer
      t.string :idAsig
      t.integer :idPer

      t.timestamps
    end
  end
end
